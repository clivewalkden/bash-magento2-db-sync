#!/usr/bin/env bash

# Use the settings to check your connection
echo -e "\n${txt_white}${bg_black}SSH Connection test.${txt_end}\n"

status=$(ssh -o BatchMode=yes -o ConnectTimeout=5 -p "${remote_port}" "${remote_username}@${remote_host}" echo ok 2>&1)

if [[ $status == ok ]]; then
    echo -e "${txt_green}Remote connection successful!${txt_end}"
elif [[ $status == "Permission denied"* ]] ; then
    echo -e "${txt_red}Permission denied${txt_end}"
    echo -e "${txt_red}Make sure you connected with the -A flag to forward your ssh agent.${txt_end}"
else
    echo -e "${txt_red}Remote connection failed${txt_end}"
fi