#!/usr/bin/env bash

# Use the settings to check your connection
echo
printf "${bg_black}${txt_white}%-80s${txt_end}\n" " "
printf "${bg_black}${txt_white}%-80s${txt_end}\n" "  SSH Connection test."
printf "${bg_black}${txt_white}%-80s${txt_end}\n" " "
echo

status=$(ssh -o BatchMode=yes -o ConnectTimeout=5 -p "${remote_port}" "${remote_username}@${remote_host}" echo ok 2>&1)

if [[ $status == ok ]]; then
    printf "${bg_green}${txt_white}%-80s${txt_end}\n" " "
    printf "${bg_green}${txt_white}%-80s${txt_end}\n" "  Remote connection successful!"
    printf "${bg_green}${txt_white}%-80s${txt_end}\n" " "
elif [[ $status == "Permission denied"* ]] ; then
    printf "${bg_red}${txt_white}%-80s${txt_end}\n" " "
    printf "${bg_red}${txt_white}${txt_bold}%-80s${txt_end}\n" "  Permission denied" 
    printf "${bg_red}${txt_white}%-80s${txt_end}\n" "  Make sure you connected with the -A flag to forward your ssh agent."
    printf "${bg_red}${txt_white}%-80s${txt_end}\n" " "
else
    printf "${bg_red}${txt_white}%-80s${txt_end}\n" " "
    printf "${bg_red}${txt_white}%-80s${txt_end}\n" "  Remote connection failed"
    printf "${bg_red}${txt_white}%-80s${txt_end}\n" " "
fi