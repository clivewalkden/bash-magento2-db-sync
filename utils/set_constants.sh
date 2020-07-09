#!/usr/bin/env bash

# to highlight errors eg. echo -e "${txt_red}Required${txt_end}"
txt_end="\e[0;0m"
txt_bold="\e[1;1m"
txt_muted="\e[1;2m"
txt_italic="\e[1;3m"
txt_underline="\e[1;4m"
txt_black="\e[1;30m"
txt_red="\e[1;31m"
txt_green="\e[1;32m"
txt_yellow="\e[1;33m"
txt_blue="\e[1;34m"
txt_magenta="\e[1;35m"
txt_cyan="\e[1;36m"
txt_white="\e[1;37m"
bg_black="\e[1;40m"
bg_red="\e[1;41m"
bg_green="\e[1;42m"
bg_yellow="\e[1;43m"
bg_blue="\e[1;44m"
bg_magenta="\e[1;45m"
bg_cyan="\e[1;46m"
bg_white="\e[1;47m"
bg_black_light="\e[1;100m"
bg_red_light="\e[1;101m"
bg_green_light="\e[1;102m"
bg_yellow_light="\e[1;103m"
bg_blue_light="\e[1;104m"
bg_magenta_light="\e[1;105m"
bg_cyan_light="\e[1;106m"
bg_white_light="\e[1;107m"

DATESTAMP=$(date +%Y%m%d%H%M%S)

# Generate 32 char string based on md5 of now in epoch format
gen_string ()
{
  # date %s # seconds since 1970-01-01 00:00:00 UTC
  # date %N # nanoseconds
  date +%s.%N |
  # md5sum -t # read in text mode
  md5sum -t |
  # awk '{print $1}' # prints the first returned variable
  awk '{print $1}'
}

function existRemoteFile ()
{
    FILE=$1
    RESULT=$(ssh -p"$remote_port" "${remote_username}@${remote_host}" "test -e $FILE" && echo \"0\" || echo \"1\")
    if [ $RESULT == 0 ]; then
        return 0
    else
        return 1
    fi
}

conf_file=../backup.conf

DB_HOST=$(n98-magerun config:env:show db.connection.default.host)
DB_USER=$(n98-magerun config:env:show db.connection.default.username)
DB_PASS=$(n98-magerun config:env:show db.connection.default.password)
DB_DBASE=$(n98-magerun config:env:show db.connection.default.dbname)

DB_WP_HOST=$(n98-magerun config:env:show db.connection.wordpress.host)
DB_WP_USER=$(n98-magerun config:env:show db.connection.wordpress.username)
DB_WP_PASS=$(n98-magerun config:env:show db.connection.wordpress.password)
DB_WP_DBASE=$(n98-magerun config:env:show db.connection.wordpress.dbname)