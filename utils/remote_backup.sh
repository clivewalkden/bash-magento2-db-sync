#!/usr/bin/env bash

# Use the settings to check your connection
echo -e "\n${txt_white}${bg_black}Backing up remote database(s).   ${txt_end}\n"
if [ $_arg_full == 'on' ]; then
    echo -e "${txt_white}${bg_black}  Full customer and order backup.${txt_end}\n"
fi

ssh -p "${remote_port}" "${remote_username}@${remote_host}" <<ENDSSH
mkdir -p $remote_backup_dir
cd $remote_magento_dir

REMOTE_DB_WP_HOST=$(n98-magerun config:env:show db.connection.wordpress.host)
REMOTE_DB_WP_USER=$(n98-magerun config:env:show db.connection.wordpress.username)
REMOTE_DB_WP_PASS=$(n98-magerun config:env:show db.connection.wordpress.password)
REMOTE_DB_WP_DBASE=$(n98-magerun config:env:show db.connection.wordpress.dbname)

if [ $_arg_full == 'on' ]; then
n98-magerun db:dump --compression="gzip" --strip="@log @sessions" --force $remote_backup_dir/latest-m2.sql.gz
else
n98-magerun db:dump --compression="gzip" --strip="@log @sessions @trade @sales" --force $remote_backup_dir/latest-m2.sql.gz
fi

if [ $_arg_wordpress == 'on' ]; then
n98-magerun db:dump --compression="gzip" --conneciton="wordpress" --force $remote_backup_dir/latest-wp.sql.gz
fi
ENDSSH
