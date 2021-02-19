#!/usr/bin/env bash

# Backup the current local database
echo -e ""
echo -e "${txt_blue}  Update the database urls to current environment.${txt_end}"
echo -e ""

# Get the URL from n98, if the first option fails it'll from from the end
if ! CURRENT_URL=$(n98-magerun config:show web/secure/base_url); then
    CURRENT_URL=$(n98-magerun config:env:show system.default.web.secure.base_url)
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
# trim multiple and trailing slashes
old_domain=$(echo ${old_domain} | sed 's:/*$::')

echo -e "${txt_blue}  Old Domain: (www.)${old_domain} to New Domain: ${new_domain}.${txt_end}"
echo -e ""

sed -i "s|www.$old_domain|$new_domain|g" "${local_backup_dir}/latest-m2.sql"
sed -i "s|$old_domain|$new_domain|g" "${local_backup_dir}/latest-m2.sql"

if [ $_arg_wordpress == 'on' ]; then
    sed -i "s|www.$old_domain|$new_domain|g" "${local_backup_dir}/latest-wp.sql"
    sed -i "s|$old_domain|$new_domain|g" "${local_backup_dir}/latest-wp.sql"
fi