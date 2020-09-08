#!/usr/bin/env bash

# Backup the current local database
echo -e "\n${txt_white}${bg_black}Update the database urls to current environment.${txt_end}\n"

CURRENT_URL=$(n98-magerun config:show web/secure/base_url)
new_domain=${CURRENT_URL,,}
# remove http://
new_domain=$(printf '%s' "${new_domain}" | sed 's/^http:\/\///g')
# remove https://
new_domain=$(printf '%s' "${new_domain}" | sed 's/^https:\/\///g')
# remove ://
new_domain=$(printf '%s' "${new_domain}" | sed 's/^:\/\///g')
# remove //
new_domain=$(printf '%s' "${new_domain}" | sed 's/^\/\///g')
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

sed -i "s|$old_domain|$new_domain|g" ../backups/latest-m2.sql

if [ $_arg_wordpress == 'on' ]; then
    sed -i "s|$old_domain|$new_domain|g" ../backups/latest-wp.sql
fi