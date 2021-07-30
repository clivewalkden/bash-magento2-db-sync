#!/usr/bin/env bash
version="1.7.1"

die()
{
	local _ret=$2
	test -n "$_ret" || _ret=1
	test "$_PRINT_HELP" = yes && dbsync_print_help >&2
	echo "$1" >&2
	exit ${_ret}
}


# Function that evaluates whether a value passed to it begins by a character
# that is a short option of an argument the script knows about.
# This is required in order to support getopts-like short options grouping.
begins_with_short_option()
{
	local first_option all_short_options='fh'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_full="off"
_arg_local_backup="off"
_arg_prefix="off"
_arg_wordpress="off"

dbsync_print_help() {
  cat <<HEREDOC

  Magento 2 DB Sync v$version

  Syncronize a database from production to staging, testing or development environments.

  Make sure you are in a Magento 2 directory before trying to run any scripts.

  Usage: db-sync.sh [-b|--local-backup] [-f|--full] [-p|--prefix] [-w|--wordpress] [-v|--version] [-h|--help]
  Options:
    -b, --local-backup: perform a backup before importing remote (off by default)
    -f, --full: full database dump (off by default)
    -p, --prefix: prefix invoices, orders, shipments etc (off by default)
    -w, --wordpress: include wordpress content (off by default)"
    -v, --version: Prints version
    -h, --help: Prints help

HEREDOC
}

# The parsing of the command-line
parse_commandline()
{
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			-b|--no-local-backup|--local-backup)
				_arg_local_backup="on"
				test "${1:0:5}" = "--no-" && _arg_local_backup="off"
				;;
			-b*)
				_arg_local_backup="on"
				_next="${_key##-b}"
				if test -n "$_next" -a "$_next" != "$_key"
				then
					{ begins_with_short_option "$_next" && shift && set -- "-b" "-${_next}" "$@"; } || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
				fi
				;;
			-f|--no-full|--full)
				_arg_full="on"
				test "${1:0:5}" = "--no-" && _arg_full="off"
				;;
			-f*)
				_arg_full="on"
				_next="${_key##-f}"
				if test -n "$_next" -a "$_next" != "$_key"
				then
					{ begins_with_short_option "$_next" && shift && set -- "-f" "-${_next}" "$@"; } || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
				fi
				;;
			-p|--no-prefix|--prefix)
				_arg_prefix="on"
				test "${1:0:5}" = "--no-" && _arg_prefix="off"
				;;
			-p*)
				_arg_prefix="on"
				_next="${_key##-p}"
				if test -n "$_next" -a "$_next" != "$_key"
				then
					{ begins_with_short_option "$_next" && shift && set -- "-p" "-${_next}" "$@"; } || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
				fi
				;;
			-w|--no-wordpress|--wordpress)
				_arg_wordpress="on"
				test "${1:0:5}" = "--no-" && _arg_wordpress="off"
				;;
			-w*)
				_arg_wordpress="on"
				_next="${_key##-w}"
				if test -n "$_next" -a "$_next" != "$_key"
				then
					{ begins_with_short_option "$_next" && shift && set -- "-w" "-${_next}" "$@"; } || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
				fi
				;;
			-v|--version)
				echo db-sync.sh - v$version
				exit 0
				;;
			-v*)
				echo db-sync.sh - v$version
				exit 0
				;;
			-h|--help)
				dbsync_print_help
				exit 0
				;;
			-h*)
				dbsync_print_help
				exit 0
				;;
			*)
				_PRINT_HELP=yes die "FATAL ERROR: Got an unexpected argument '$1'" 1
				;;
		esac
		shift
	done
}

parse_commandline "$@"
