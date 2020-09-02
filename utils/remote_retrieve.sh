#!/usr/bin/env bash

# Use the settings to check your connection
echo -e "\n${txt_white}${bg_black}Retrieving database(s).${txt_end}\n"

remote_m2_db_file="$remote_backup_dir/latest-m2.sql.gz"
remote_wp_db_file="$remote_backup_dir/latest-wp.sql.gz"

mkdir -p ../backups

scp -C -P "${remote_port}" "${remote_username}@${remote_host}:$remote_m2_db_file" ../backups/latest-m2.sql.gz
gunzip -f ../backups/latest-m2.sql.gz

if [ $_arg_wordpress == 'on' ]; then
    scp -C -P "${remote_port}" "${remote_username}@${remote_host}:$remote_backup_dir/latest-wp.sql.gz" ../backups/latest-wp.sql.gz
    gunzip -f ../backups/latest-wp.sql.gz
fi
