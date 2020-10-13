#!/usr/bin/env bash

# Set data
echo -e ""
echo -e "${txt_blue}  Enter the local server info.${txt_end}"
echo -e ""

# loop until validation
while [[ -z ${local_backup_dir} ]]; do

  # prompt and set ${local_backup_dir}
  read -p $'\e[1mLocal Backup Dir (full server path)\e[0m: ' -r -e local_backup_dir

  if [[ -z ${local_backup_dir} ]]; then

    echo -e "${txt_red}Local Backup Directory is required${txt_end}"

  fi
done

# loop until validation
while [[ -z ${local_shared_deployment_dir} ]]; do

  # prompt and set ${local_shared_deployment_dir}
  read -p $'\e[1mLocal Shared Dir (full server path)\e[0m: ' -r -e local_shared_deployment_dir

  if [[ -z ${local_shared_deployment_dir} ]]; then

    echo -e "${txt_red}Local Shared Directory is required${txt_end}"

  fi
done

while [[ -z ${local_file_user} ]]; do

  # prompt and set ${local_file_user}
  read -p $'\e[1mFile Owner\e[0m: ' -r -e local_file_user

  if [[ -z ${local_file_user} ]]; then

    echo -e "${txt_red}File Owner is required${txt_end}"

  fi
done

while [[ -z ${local_file_group} ]]; do

  # prompt and set ${local_file_group}
  read -p $'\e[1mFile Group\e[0m: ' -r -e local_file_group

  if [[ -z ${local_file_group} ]]; then

    echo -e "${txt_red}File Group is required${txt_end}"

  fi
done

echo -e "\n"
echo -e " ${txt_green}Using the following for local host${txt_end}"
echo -e " ${txt_green}  Local Backup Directory:                   ${txt_yellow}${local_backup_dir}${txt_end}"
echo -e " ${txt_green}  Local Shared Deployment Directory:        ${txt_yellow}${local_shared_deployment_dir}${txt_end}"
echo -e " ${txt_green}  Local File Owner:                         ${txt_yellow}${local_file_user}${txt_end}"
echo -e " ${txt_green}  Local File Group:                         ${txt_yellow}${local_file_group}${txt_end}"
echo -e "\n"
