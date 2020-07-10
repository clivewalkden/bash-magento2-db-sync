#!/usr/bin/env bash

## Assumptions
# A ssh key is available to connect to the box
#

# set path to allow calling util subdir files
source "set_util"

# Load the menu and help
source "${util}menu.sh"

# Make sure we are in a Magento directory
if [ ! -f "bin/magento" ]; then
    echo -e "${bg_red}                                                ${txt_end}"
    echo -e "${bg_red}${txt_white}  You are not currently in a Magento directory  ${txt_end}"
    echo -e "${bg_red}                                                ${txt_end}"
    exit
fi

# Set global paths and functions
source "${util}set_constants.sh"

echo -e "${bg_black}${txt_white}                                              ${txt_end}"
echo -e "${bg_black}${txt_white}  Copy over a production database to staging  ${txt_end}"
echo -e "${bg_black}${txt_white}                                              ${txt_end}"

# Check for a local config file
echo -e "\n${txt_white}${bg_black}Checking for local configuration file (${conf_file}).${txt_end}\n"
if [[ -f "$conf_file" ]]; then
    . "$conf_file"
fi

set -e

# Set ${remote_host}
source "${util}set_remote_host.sh"

# Test Connection
while true; do
  echo -e "\n"
  read -p "Would you like to test the connection? " yn

  case $yn in
    [Yy]* ) source "${util}ssh_connection_test.sh"; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done

# Run the remote backup
source "${util}remote_backup.sh"
source "${util}remote_retrieve.sh"
source "${util}local_backup.sh"
source "${util}url_update.sh"

# Import the database(s)
while true; do
  echo -e "\n"
  read -p "Are you ready to import databases to local system? " yn

  case $yn in
    [Yy]* ) source "${util}local_import.sh"; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done

# Import latest imagery
while true; do
  echo -e "\n"
  read -p "Do you want to download the latest imagery? " yn

  case $yn in
    [Yy]* ) source "${util}local_imagery_import.sh"; break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done

echo -e "\n${txt_white}${bg_black}Run the Magento configuration.${txt_end}\n"
n98-magerun setup:upgrade
echo
n98-magerun deploy:mode:set developer
echo
n98-magerun setup:di:compile
echo
n98-magerun indexer:reindex
echo
n98-magerun cache:flush

echo -e "\n${txt_green}Database migrated: ${domain}${txt_end}\n"