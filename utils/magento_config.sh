#!/usr/bin/env bash

echo
printf "${bg_black}${txt_white}%-80s${txt_end}\n" " "
printf "${bg_black}${txt_white}%-80s${txt_end}\n" "  Run the Magento configuration."
printf "${bg_black}${txt_white}%-80s${txt_end}\n" " "

echo
echo -e "${txt_blue}  Magento Setup Upgrade.  ${txt_end}"
echo
n98-magerun --quiet --no-interaction setup:upgrade
echo
echo -e "${txt_blue}  Magento Setup DI Compile.  ${txt_end}"
echo
n98-magerun --quiet --no-interaction setup:di:compile
echo
echo -e "${txt_blue}  Magento Static Content Deploy.  ${txt_end}"
echo
n98-magerun --quiet --no-interaction setup:static-content:deploy -f -j8 en_GB en_US
echo
echo -e "${txt_blue}  Magento Reindex.  ${txt_end}"
echo
n98-magerun --quiet --no-interaction indexer:reindex
echo
echo -e "${txt_blue}  Magento Cache Flush.  ${txt_end}"
echo
n98-magerun --quiet --no-interaction cache:flush