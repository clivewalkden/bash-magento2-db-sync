#!/usr/bin/env bash

# Backup the current local database
echo
echo -e "${txt_blue}  Importing into local database(s).${txt_end}"
echo

mysql -h$DB_HOST -u$DB_USER -p$DB_PASS $DB_DBASE<$local_backup_dir/latest-m2.sql

if [ $_arg_wordpress == 'on' ]; then
    mysql -h$DB_WP_HOST -u$DB_WP_USER -p$DB_WP_PASS $DB_WP_DBASE<$local_backup_dir/latest-wp.sql
fi