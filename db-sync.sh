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
    printf '%-1s %-80s %-1s' "${bg_red}${txt_white}" " " "${txt_end}"
    echo -e "${bg_red}${txt_white}  You are not currently in a Magento directory  ${txt_end}"
    echo -e "${bg_red}${txt_white}                                                ${txt_end}"
    exit
fi

# Set global paths and functions
source "${dbsyncutil}set_constants.sh"

echo -e "${bg_black}${txt_white}                                              ${txt_end}"
echo -e "${bg_black}${txt_white}  Copy over a production database to staging  ${txt_end}"
echo -e "${bg_black}${txt_white}                                              ${txt_end}"

# Check for a local config file
echo -e ""
echo -e "${txt_blue}  Checking for local configuration file (${conf_file}).  ${txt_end}"
echo -e ""
if [[ -f "$conf_file" ]]; then
    . "$conf_file"
    echo -e "${txt_blue}  Loaded from config.  ${txt_end}"
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

echo -e ""
echo -e "${txt_blue}  Run the Magento configuration.  ${txt_end}"
echo -e ""

n98-magerun setup:upgrade
echo
n98-magerun setup:di:compile
echo 
n98-magerun setup:static-content:deploy -f -j8 en_GB en_US
echo
n98-magerun indexer:reindex
echo
n98-magerun cache:flush

echo -e "${bg_green}${txt_white}${txt_bold}                                             ${txt_end}"
echo -e "${bg_green}${txt_white}${txt_bold}  Database migrated: ${txt_yellow}${new_domain}  ${txt_end}"
echo -e "${bg_green}${txt_white}${txt_bold}                                             ${txt_end}"