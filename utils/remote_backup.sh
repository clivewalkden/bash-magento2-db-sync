#!/usr/bin/env bash

# Use the settings to check your connection
echo -e "\n${txt_white}${bg_black}Backing up remote database(s).   ${txt_end}\n"
if [ $_arg_full == 'on' ]; then
echo -e "\n${txt_white}${bg_black}  Full customer and order backup.${txt_end}\n"
fi

ssh -p "${remote_port}" "${remote_username}@${remote_host}" <<ENDSSH
mkdir -p $remote_backup_dir
cd $remote_magento_dir

REMOTE_DB_HOST=$(n98-magerun config:env:show db.connection.default.host)
REMOTE_DB_USER=$(n98-magerun config:env:show db.connection.default.username)
REMOTE_DB_PASS=$(n98-magerun config:env:show db.connection.default.password)
REMOTE_DB_DBASE=$(n98-magerun config:env:show db.connection.default.dbname)

REMOTE_DB_WP_HOST=$(n98-magerun config:env:show db.connection.wordpress.host)
REMOTE_DB_WP_USER=$(n98-magerun config:env:show db.connection.wordpress.username)
REMOTE_DB_WP_PASS=$(n98-magerun config:env:show db.connection.wordpress.password)
REMOTE_DB_WP_DBASE=$(n98-magerun config:env:show db.connection.wordpress.dbname)

if [ $_arg_full == 'on' ]; then
n98-magerun db:dump --compression="gzip" --strip="@log @sessions" --force $remote_backup_dir/latest-m2.sql.gz
else
n98-magerun db:dump --compression="gzip" --strip="@log @sessions @trade @sales" --force $remote_backup_dir/latest-m2.sql.gz
fi

if [ ! -z $REMOTE_DB_WP_HOST ]; then
mysqldump -h$REMOTE_DB_WP_HOST -u$REMOTE_DB_WP_USER -p$REMOTE_DB_WP_PASS $REMOTE_DB_WP_DBASE>$remote_backup_dir/latest-wp.sql
gzip -f $remote_backup_dir/latest-wp.sql
fi
ENDSSH
