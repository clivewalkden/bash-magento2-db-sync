#!/usr/bin/env bash

# Backup the current local database
echo -e ""
echo -e "${txt_blue}  Importing imagery from live.${txt_end}"
echo -e ""

# Set the default directories to transfer
source=("/pub/media/" "/wp/wp-content/uploads/")
dest=("./pub/media/" "./wp/wp-content/uploads/")

for i in "${!source[@]}"; do
    rsync -rlDhP --exclude 'cache*' -e "ssh -p${remote_port}" "$remote_username@$remote_host:$remote_shared_deployment_dir${source[$i]}" "${dest[$i]}"
done
