#!/usr/bin/env bash

echo
printf "${bg_black}${txt_white}%-80s${txt_end}\n" " "
printf "${bg_black}${txt_white}%-80s${txt_end}\n" " Deleting backups. "
printf "${bg_black}${txt_white}%-80s${txt_end}\n" " "

# Delete remote db backups
ssh -p "${remote_port}" "${remote_username}@${remote_host}" rm -f $remote_backup_dir/latest-m2.sql.gz
ssh -p "${remote_port}" "${remote_username}@${remote_host}" rm -f $remote_backup_dir/latest-wp.sql.gz