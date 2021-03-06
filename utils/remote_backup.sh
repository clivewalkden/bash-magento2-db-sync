#!/usr/bin/env bash

# Use the settings to check your connection
echo
printf "${bg_black}${txt_white}%-80s${txt_end}\n" " "
printf "${bg_black}${txt_white}%-80s${txt_end}\n" " Backing up remote database(s). "
if [ $_arg_full == 'on' ]; then
    printf "${bg_black}${txt_white}%-80s${txt_end}\n" " Full customer and order backup. "
fi
printf "${bg_black}${txt_white}%-80s${txt_end}\n" " "

ssh -p "${remote_port}" "${remote_username}@${remote_host}" <<ENDSSH
mkdir -p $remote_backup_dir
cd $remote_magento_dir

REMOTE_DB_WP_HOST=$(n98-magerun config:env:show db.connection.wordpress.host)
REMOTE_DB_WP_USER=$(n98-magerun config:env:show db.connection.wordpress.username)
REMOTE_DB_WP_PASS=$(n98-magerun config:env:show db.connection.wordpress.password)
REMOTE_DB_WP_DBASE=$(n98-magerun config:env:show db.connection.wordpress.dbname)

if [ $_arg_full == 'on' ]; then
n98-magerun --quiet --no-interaction db:dump --compression="gzip" --strip="@log @sessions" --force $remote_backup_dir/latest-m2.sql.gz
else
n98-magerun --quiet --no-interaction db:dump --compression="gzip" --strip="@log @sessions @trade @sales $ignore_tables" --force $remote_backup_dir/latest-m2.sql.gz
fi

if [ $_arg_wordpress == 'on' ]; then
n98-magerun --quiet --no-interaction db:dump --compression="gzip" --connection="wordpress" --force $remote_backup_dir/latest-wp.sql.gz
fi
ENDSSH
