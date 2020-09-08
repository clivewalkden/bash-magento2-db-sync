#!/usr/bin/env bash

# Use the settings to check your connection
echo -e "${bg_black}${txt_white}                        ${txt_end}"
echo -e "${bg_black}${txt_white}  SSH Connection test.  ${txt_end}"
echo -e "${bg_black}${txt_white}                        ${txt_end}"

status=$(ssh -o BatchMode=yes -o ConnectTimeout=5 -p "${remote_port}" "${remote_username}@${remote_host}" echo ok 2>&1)

if [[ $status == ok ]]; then
    echo -e "${bg_green}${txt_white}                                 ${txt_end}"
    echo -e "${bg_green}${txt_white}  Remote connection successful!  ${txt_end}"
    echo -e "${bg_green}${txt_white}                                 ${txt_end}"
elif [[ $status == "Permission denied"* ]] ; then
    echo -e "${bg_red}${txt_white}                                                                       ${txt_end}"
    echo -e "${bg_red}${txt_white}${txt_bold}  Permission denied                                                    ${txt_end}"
    echo -e "${bg_red}${txt_white}  Make sure you connected with the -A flag to forward your ssh agent.  ${txt_end}"
    echo -e "${bg_red}${txt_white}                                                                       ${txt_end}"
else
    echo -e "${bg_red}${txt_white}                            ${txt_end}"
    echo -e "${bg_red}${txt_white}  Remote connection failed  ${txt_end}"
    echo -e "${bg_red}${txt_white}                            ${txt_end}"
fi