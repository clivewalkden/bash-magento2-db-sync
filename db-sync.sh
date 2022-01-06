#!/usr/bin/env bash

## Assumptions
# A ssh key is available to connect to the box
#

# set path to allow calling util subdir files
#source "set_util"
dbsyncutil="$( dirname ${BASH_SOURCE[0]} )/utils/"

# Load the menu and help
source "${dbsyncutil}menu.sh"

# Make sure we are in a Magento directory
if [ ! -f "bin/magento" ]; then
    printf "${bg_red}${txt_white}%-80s${txt_end}\n" " "
    printf "${bg_red}${txt_white}%-80s${txt_end}\n" "  You are not currently in a Magento directory"
    printf "${bg_red}${txt_white}%-80s${txt_end}\n" " "
    exit
fi

# Set global paths and functions
source "${dbsyncutil}set_constants.sh"

printf "${bg_black}${txt_white}%-80s${txt_end}\n" " "
printf "${bg_black}${txt_white}%-80s${txt_end}\n" "  Copy over a production database to staging"
printf "${bg_black}${txt_white}%-80s${txt_end}\n" " "

# Check for a local config file
echo -e ""
echo -e "${txt_blue}  Checking for local configuration file (${conf_file}).  ${txt_end}"
echo -e ""
# Load config from either .ini or .conf
if [[ -f "$ini_file" ]]; then
    source "${dbsyncutil}shini.sh"
    source "${dbsyncutil}read_ini.sh"
    echo -e "${txt_blue}  Loaded from ini.  ${txt_end}"
elif [[ -f "$conf_file" ]]; then
    . "$conf_file"
    echo -e "${txt_blue}  Loaded from config.  ${txt_end}"
else
    echo -e "${txt_blue}  No config to load.  ${txt_end}"
fi


set -e

# Set ${remote_host}
source "${dbsyncutil}set_remote_host.sh"
source "${dbsyncutil}set_local_vars.sh"

# Test Connection
while true; do
  echo -e "\n"
  read -p "Would you like to test the connection? " yn

  case $yn in
    [Yy]* ) source "${dbsyncutil}ssh_connection_test.sh"; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done

# Run the remote backup
source "${dbsyncutil}remote_backup.sh"
source "${dbsyncutil}remote_retrieve.sh"
source "${dbsyncutil}cleanup.sh"
source "${dbsyncutil}local_backup.sh"
source "${dbsyncutil}url_update.sh"

# Import the database(s)
while true; do
  echo -e "\n"
  read -p "Are you ready to import databases to local system? " yn

  case $yn in
    [Yy]* ) source "${dbsyncutil}local_import.sh"; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done

# Add prefix to sequence table
if [ $_arg_prefix == 'on' ]; then
  source "${dbsyncutil}prefix.sh";
fi

# Import latest imagery
while true; do
  echo -e "\n"
  read -p "Do you want to download the latest imagery? " yn

  case $yn in
    [Yy]* ) source "${dbsyncutil}local_imagery_import.sh"; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done

# Run Magento Config
while true; do
  echo -e "\n"
  read -p "Would you like to run Magento commands? " yn

  case $yn in
    [Yy]* ) source "${dbsyncutil}magento_config.sh"; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done

echo
printf "${bg_green}${txt_white}%-80s${txt_end}\n" " "
printf "${bg_green}${txt_white}${txt_bold}%-21s ${txt_yellow}%-58s${txt_end}\n" "  Database migrated:" "${new_domain}"
printf "${bg_green}${txt_white}%-80s${txt_end}\n" " "
echo
