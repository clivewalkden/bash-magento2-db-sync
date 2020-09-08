#!/usr/bin/env bash

if [ $_arg_local_backup == 'on' ]; then
    # Backup the current local database
    echo -e ""
    echo -e "${txt_blue}  Backing up local database(s).${txt_end}"
    echo -e ""

    n98-magerun --ansi --root-dir="${PWD}" db:dump --compression="gzip" --force "../backups/$DATESTAMP-m2.sql.gz"

    if [ $_arg_wordpress == 'on' ]; then
        n98-magerun --ansi --root-dir="${PWD}" db:dump --compression="gzip" --connection="wordpress" --force "../backups/$DATESTAMP-wp.sql.gz"
    fi
else
    # No local backup
    echo -e ""
    echo -e "${txt_blue}  Skipping local database(s) backup.${txt_end}"
    echo -e ""
fi