#!/usr/bin/env bash

# Backup the current local database
echo -e "\n${txt_white}${bg_black}Importing into local database(s).${txt_end}\n"

mysql -h$DB_HOST -u$DB_USER -p$DB_PASS $DB_DBASE<../backups/latest-m2.sql

if [ $_arg_wordpress == 'on' ]; then
    mysql -h$DB_WP_HOST -u$DB_WP_USER -p$DB_WP_PASS $DB_WP_DBASE<../backups/latest-wp.sql
fi