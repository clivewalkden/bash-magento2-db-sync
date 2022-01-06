#!/usr/bin/env bash

# Set data
echo
echo -e "${txt_blue}  Enter the remote server info.${txt_end}"
echo

# loop until validation
while [[ -z ${remote_host} ]]; do

  # prompt and set ${remote_host}
  read -p $'\e[1mRemote Host (domain or ip)\e[0m: ' -r -e remote_host

  if [[ -z ${remote_host} ]]; then

    echo -e "${txt_red}Remote Host is required${txt_end}"

  fi
done

while [[ -z ${remote_domain} ]]; do

  # prompt and set ${remote_domain}
  read -p $'\e[1mRemote Domain (no need to https://)\e[0m: ' -r -e remote_domain

  if [[ -z ${remote_domain} ]]; then

    echo -e "${txt_red}Remote Domain is required${txt_end}"

  fi
done

while [[ -z ${remote_port} ]]; do

  # prompt and set ${remote_port}
  read -p $'\e[1mRemote Port\e[0m: ' -r -e remote_port

  if [[ -z ${remote_port} ]]; then

    echo -e "${txt_red}Remote Port is required${txt_end}"

  fi
done

while [[ -z ${remote_username} ]]; do

  # prompt and set ${remote_username}
  read -p $'\e[1mRemote Username\e[0m: ' -r -e remote_username

  if [[ -z ${remote_username} ]]; then

    echo -e "${txt_red}Remote Username is required${txt_end}"

  fi
done

while [[ -z ${remote_magento_dir} ]]; do

  # prompt and set ${remote_magento_dir}
  read -p $'\e[1mRemote hosts Magento directory\e[0m: ' -r -e remote_magento_dir

  if [[ -z ${remote_magento_dir} ]]; then

    echo -e "${txt_red}Remote hosts Magento directory is required${txt_end}"

  fi
done

while [[ -z ${remote_backup_dir} ]]; do

  # prompt and set ${remote_backup_dir}
  read -p $'\e[1mRemote hosts backup directory\e[0m: ' -r -e remote_backup_dir

  if [[ -z ${remote_backup_dir} ]]; then

    echo -e "${txt_red}Remote hosts backup directory is required${txt_end}"

  fi
done

while [[ -z ${remote_shared_deployment_dir} ]]; do

  # prompt and set ${remote_shared_deployment_dir}
  read -p $'\e[1mRemote hosts shared deployment directory\e[0m: ' -r -e remote_shared_deployment_dir

  if [[ -z ${remote_shared_deployment_dir} ]]; then

    echo -e "${txt_red}Remote hosts shared deployment directory is required${txt_end}"

  fi
done

echo
printf "${txt_green}%-80s${txt_end}\n" "Using the following for Remote host"
printf "${txt_green}%-40s ${txt_yellow}%-40s${txt_end}\n" " Host:" "${remote_host}"
printf "${txt_green}%-40s ${txt_yellow}%-40s${txt_end}\n" " Domain:" "${remote_domain}"
printf "${txt_green}%-40s ${txt_yellow}%-40s${txt_end}\n" " Port:" "${remote_port}"
printf "${txt_green}%-40s ${txt_yellow}%-40s${txt_end}\n" " Username:" "${remote_username}"
printf "${txt_green}%-40s ${txt_yellow}%-40s${txt_end}\n" " Host Magento Dir:" "${remote_magento_dir}"
printf "${txt_green}%-40s ${txt_yellow}%-40s${txt_end}\n" " Host Backup Dir:" "${remote_backup_dir}"
printf "${txt_green}%-40s ${txt_yellow}%-40s${txt_end}\n" " Host Shared Deployment Backup Dir:" "${remote_shared_deployment_dir}"
printf "${txt_green}%-40s ${txt_yellow}%-40s${txt_end}\n" " Remote PHP Bin:" "${remote_php_path}"
printf "${txt_green}%-40s ${txt_yellow}%-40s${txt_end}\n" " Remote n98-magerun Bin:" "${remote_n98_path}"
echo
