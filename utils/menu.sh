#!/usr/bin/env bash

die()
{
	local _ret=$2
	test -n "$_ret" || _ret=1
	test "$_PRINT_HELP" = yes && dbsynchelp >&2
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

dbsynchelp() {
  cat <<-HEREDOC
  Magento 2 DB Sync v1.2.1

  Syncronize a database from production to staging, testing or development environments.

  Make sure you are in a Magento 2 directory before trying to run any scripts.

  Usage: db-sync.sh [-f|--(no-)full] [-h|--help]
  Options:
    -f, --full, --no-full: full database dump (off by default)
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
			# The full argurment doesn't accept a value,
			# we expect the --full or -f, so we watch for them.
			-f|--no-full|--full)
				_arg_full="on"
				test "${1:0:5}" = "--no-" && _arg_full="off"
				;;
			# We support getopts-style short arguments clustering,
			# so as -f doesn't accept value, other short options may be appended to it, so we watch for -f*.
			# After stripping the leading -f from the argument, we have to make sure
			# that the first character that follows coresponds to a short option.
			-f*)
				_arg_full="on"
				_next="${_key##-f}"
				if test -n "$_next" -a "$_next" != "$_key"
				then
					{ begins_with_short_option "$_next" && shift && set -- "-f" "-${_next}" "$@"; } || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
				fi
				;;
			# See the comment of option '--full' to see what's going on here - principle is the same.
			-h|--help)
				dbsynchelp
				exit 0
				;;
			# See the comment of option '-f' to see what's going on here - principle is the same.
			-h*)
				dbsynchelp
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
