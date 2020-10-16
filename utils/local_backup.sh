#!/usr/bin/env bash

if [ $_arg_local_backup == 'on' ]; then
    # Backup the current local database
    echo
    echo -e "${txt_blue}  Backing up local database(s).${txt_end}"
    echo

    n98-magerun --quiet --no-interaction --root-dir="${PWD}" db:dump --compression="gzip" --force "${local_backup_dir}/$DATESTAMP-m2.sql.gz"

    if [ $_arg_wordpress == 'on' ]; then
        n98-magerun --quiet --no-interaction --root-dir="${PWD}" db:dump --compression="gzip" --connection="wordpress" --force "${local_backup_dir}/$DATESTAMP-wp.sql.gz"
    fi
else
    # No local backup
    echo
    echo -e "${txt_blue}  Skipping local database(s) backup.${txt_end}"
    echo
fi