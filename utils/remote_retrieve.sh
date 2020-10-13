#!/usr/bin/env bash

# Use the settings to check your connection
echo -e ""
echo -e "${txt_blue}  Retrieving database(s).${txt_end}"
echo -e ""

remote_m2_db_file="$remote_backup_dir/latest-m2.sql.gz"
remote_wp_db_file="$remote_backup_dir/latest-wp.sql.gz"

while [[ -z ${local_backup_dir} ]]; do
    # prompt and set ${local_backup_dir}
    read -p $'\e[1mLocal host backup directory\e[0m: ' -r -e local_backup_dir

    if [[ -z ${local_backup_dir} ]]; then
        echo -e "${txt_red}Local host backup directory is required${txt_end}"
    fi
done

mkdir -p "${local_backup_dir}"

scp -C -P "${remote_port}" "${remote_username}@${remote_host}:${remote_m2_db_file}" "${local_backup_dir}/latest-m2.sql.gz"
gunzip -f "${local_backup_dir}/latest-m2.sql.gz"

if [ $_arg_wordpress == 'on' ]; then
    scp -C -P "${remote_port}" "${remote_username}@${remote_host}:${remote_backup_dir}/latest-wp.sql.gz" "${local_backup_dir}/latest-wp.sql.gz"
    gunzip -f "${local_backup_dir}/latest-wp.sql.gz"
fi
