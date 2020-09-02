#!/usr/bin/env bash

# Backup the current local database
echo -e "\n${txt_white}${bg_black}Importing imagery from live.${txt_end}\n"

# Set the default directories to transfer
source=("/pub/media/" "/wp/wp-content/uploads/")
dest=("./pub/media/" "./wp/wp-content/uploads/")

for i in "${!source[@]}"; do
    rsync -rlDhP --exclude 'cache*' -e "ssh -p${remote_port}" "$remote_username@$remote_host:$remote_shared_deployment_dir${source[$i]}" "${dest[$i]}"
done
