#!/usr/bin/env bash

if [ $_arg_local_backup == 'on' ]; then
    # Backup the current local database
    echo -e "\n${txt_white}${bg_black}Backing up local database(s).${txt_end}\n"

    n98-magerun --root-dir="${PWD}" db:dump --compression="gzip" --force "../backups/$DATESTAMP-m2.sql.gz"

    if [ $_arg_wordpress == 'on' ]; then
        n98-magerun --root-dir="${PWD}" db:dump --compression="gzip" --connection="wordpress" --force "../backups/$DATESTAMP-wp.sql.gz"
    fi
else
    # No local backup
    echo -e "\n${txt_white}${bg_black}Skipping local database(s) backup.${txt_end}\n"
fi