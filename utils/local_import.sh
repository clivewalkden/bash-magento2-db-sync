#!/usr/bin/env bash

# Backup the current local database
echo
echo -e "${txt_blue}  Importing into local database(s).${txt_end}"
echo

n98-magerun db:import --force --drop-tables $local_backup_dir/latest-m2.sql

if [ $_arg_wordpress == 'on' ]; then
    cd wp
    sed -i '1s/^/SET SQL_MODE='\''ALLOW_INVALID_DATES'\'';\n\n/' $local_backup_dir/latest-wp.sql
    
    wp db import $local_backup_dir/latest-wp.sql

    wp search-replace "www.$old_domain" "$new_domain" --skip-columns=guid
    wp search-replace "$old_domain" "$new_domain" --skip-columns=guid
fi