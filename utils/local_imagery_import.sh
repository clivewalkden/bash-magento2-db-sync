#!/usr/bin/env bash

# Backup the current local database
echo
echo -e "${txt_blue}  Importing imagery from live.${txt_end}"
echo

# Set the default directories to transfer
source=("/pub/media/" "/wp/wp-content/uploads/")
dest=("${local_shared_deployment_dir}/pub/media/" "${local_shared_deployment_dir}/wp/wp-content/uploads/")

for i in "${!source[@]}"; do
    rsync --recursive --links --human-readable --partial --progress --compress --perms --exclude={'cache*','sozo_imagify/*'} -e "ssh -p${remote_port}" "$remote_username@$remote_host:$remote_shared_deployment_dir${source[$i]}" "${dest[$i]}"
    sudo chown -R $local_file_user:$local_file_group "${dest[$i]}"
done
