#!/usr/bin/env bash

# Use the settings to check your connection
echo
printf "${bg_black}${txt_white}%-80s${txt_end}\n" " "
printf "${bg_black}${txt_white}%-80s${txt_end}\n" " Backing up remote database(s). "
if [ $_arg_full == 'on' ]; then
    printf "${bg_black}${txt_white}%-80s${txt_end}\n" " Full customer and order backup. "
fi
printf "${bg_black}${txt_white}%-80s${txt_end}\n" " "

# Get the URL from n98, if the first option fails it'll try the next
if ! CURRENT_URL=$(n98-magerun config:env:show system.default.web.secure.base_url); then
    CURRENT_URL=$(n98-magerun config:show web/secure/base_url)
fi

new_domain=${CURRENT_URL,,}
# remove http://
new_domain=$(printf '%s' "${new_domain}" | sed 's/^http:\/\///g')
# remove https://
new_domain=$(printf '%s' "${new_domain}" | sed 's/^https:\/\///g')
# remove ://
new_domain=$(printf '%s' "${new_domain}" | sed 's/^:\/\///g')
# remove //
new_domain=$(printf '%s' "${new_domain}" | sed 's/^\/\///g')
# remove www.
new_domain=$(printf '%s' "${new_domain}" | sed 's/^www\.//g')
# trim multiple and trailing slashes
new_domain=$(echo ${new_domain} | sed 's:/*$::')

old_domain=${remote_domain,,}
# remove http://
old_domain=$(printf '%s' "${old_domain}" | sed 's/^http:\/\///g')
# remove https://
old_domain=$(printf '%s' "${old_domain}" | sed 's/^https:\/\///g')
# remove ://
old_domain=$(printf '%s' "${old_domain}" | sed 's/^:\/\///g')
# remove //
old_domain=$(printf '%s' "${old_domain}" | sed 's/^\/\///g')

# replace . with \.
old_domain="${old_domain//./\.}" 

# trim multiple and trailing slashes
old_domain=$(echo ${old_domain} | sed 's:/*$::')

ssh -p "${remote_port}" "${remote_username}@${remote_host}" <<ENDSSH
mkdir -p $remote_backup_dir
cd $remote_magento_dir

# Check the commands are available
if ! command -v $remote_php_path &> /dev/null
then
    echo "$remote_php_path could not be found"
    exit
fi

if ! command -v $remote_n98_path &> /dev/null
then
    echo "$remote_n98_path could not be found"
    exit
fi

if [ $_arg_full == 'on' ]; then
$remote_php_path $remote_n98_path --quiet --no-interaction db:dump --no-tablespaces --compression="gzip" --strip="@log @sessions" --force $remote_backup_dir/latest-m2.sql.gz
else
$remote_php_path $remote_n98_path --quiet --no-interaction db:dump --no-tablespaces --compression="gzip" --strip="@log @sessions @trade @sales @idx @aggregated @temp @newrelic_reporting $ignore_tables" --force $remote_backup_dir/latest-m2.sql.gz
fi

if [ $_arg_wordpress == 'on' ]; then
cd wp
wp search-replace '$old_domain' '$new_domain' --all-tables --export | gzip > $remote_backup_dir/latest-wp.sql.gz
fi
ENDSSH
