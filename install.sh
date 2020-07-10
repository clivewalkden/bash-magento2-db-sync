#!/usr/bin/env bash

{ # this ensures the entire script is downloaded #

dbsync_install_dir() {
    printf %s "${HOME}/.dbsync"
}

dbsync_latest_version() {
  echo "v1.2.1"
}

#
# Outputs the location to DB Sync depending on:
# * The availability of $GIT_SOURCE
#
dbsync_source() {
  local DBSYNC_METHOD
  DBSYNC_METHOD="$1"
  local DBSYNC_SOURCE_URL
  DBSYNC_SOURCE_URL="https://github.com/clivewalkden/bash-magento2-db-sync.git"
  echo "$DBSYNC_SOURCE_URL"
}

do_install() {
    local INSTALL_DIR
    INSTALL_DIR="$(dbsync_install_dir)"

    # Downloading to $INSTALL_DIR
    mkdir -p "$INSTALL_DIR"
    if [ -f "$INSTALL_DIR/db-sync.sh" ]; then
        echo "=> db-sync is already installed in $INSTALL_DIR, trying to update the script"
    else
        echo "=> Downloading db-sync as script to '$INSTALL_DIR'"
    fi

    if [ -d "$INSTALL_DIR/.git" ]; then
        echo "=> db-sync is already installed in $INSTALL_DIR, trying to update using git"
        command printf '\r=> '
        command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" fetch origin tag "$(dbsync_latest_version)" --depth=1 2> /dev/null || {
        echo >&2 "Failed to update db-sync, run 'git fetch' in $INSTALL_DIR yourself."
        exit 1
        }
    else
        # Cloning to $INSTALL_DIR
        echo "=> Downloading db-sync from git to '$INSTALL_DIR'"
        command printf '\r=> '
        mkdir -p "${INSTALL_DIR}"
        if [ "$(ls -A "${INSTALL_DIR}")" ]; then
        command git init "${INSTALL_DIR}" || {
            echo >&2 'Failed to initialize db-sync repo. Please report this!'
            exit 2
        }
        command git --git-dir="${INSTALL_DIR}/.git" remote add origin "$(dbsync_source)" 2> /dev/null \
            || command git --git-dir="${INSTALL_DIR}/.git" remote set-url origin "$(dbsync_source)" || {
            echo >&2 'Failed to add remote "origin" (or set the URL). Please report this!'
            exit 2
        }
        command git --git-dir="${INSTALL_DIR}/.git" fetch origin tag "$(dbsync_latest_version)" --depth=1 || {
            echo >&2 'Failed to fetch origin with tags. Please report this!'
            exit 2
        }
        else
        command git -c advice.detachedHead=false clone "$(dbsync_source)" -b "$(dbsync_latest_version)" --depth=1 "${INSTALL_DIR}" || {
            echo >&2 'Failed to clone dbsync repo. Please report this!'
            exit 2
        }
        fi
    fi
    command git -c advice.detachedHead=false --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" checkout -f --quiet "$(dbsync_latest_version)"
    if [ -n "$(command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" show-ref refs/heads/master)" ]; then
        if command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" branch --quiet 2>/dev/null; then
        command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" branch --quiet -D master >/dev/null 2>&1
        else
        echo >&2 "Your version of git is out of date. Please update it!"
        command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" branch -D master >/dev/null 2>&1
        fi
    fi

    echo "=> Compressing and cleaning up git repository"
    if ! command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" reflog expire --expire=now --all; then
        echo >&2 "Your version of git is out of date. Please update it!"
    fi
    if ! command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" gc --auto --aggressive --prune=now ; then
        echo >&2 "Your version of git is out of date. Please update it!"
    fi

    local PROFILE_INSTALL_DIR
    PROFILE_INSTALL_DIR="$(dbsync_install_dir | command sed "s:^$HOME:\$HOME:")"
    SOURCE_STR="\\nexport DBSYNC_DIR=\"${PROFILE_INSTALL_DIR}\"\\nif [ -f \"\$DBSYNC_DIR/db-sync.sh\" ]; then\\n\t export PATH=\"$INSTALL_DIR:\$PATH\"\\nfi  # This loads db-sync\\n"
    local DBSYNC_PROFILE
    DBSYNC_PROFILE="${HOME}/.bashrc"

    if ! command grep -qc '/db-sync.sh' "${DBSYNC_PROFILE}"; then
      echo "=> Appending db-sync source string to ${DBSYNC_PROFILE}"
      command printf "${SOURCE_STR}" >> "${DBSYNC_PROFILE}"
    else
      echo "=> db-sync source string already in ${DBSYNC_PROFILE}"
    fi

    \. "${DBSYNC_PROFILE}"

    dbsync_reset

    echo "=> Close and reopen your terminal to start using db-sync.sh"
}

#
# Unsets the various functions defined
# during the execution of the install script
#
dbsync_reset() {
  unset -f dbsync_install_dir dbsync_latest_version dbsync_source do_install
}

do_install

} # this ensures the entire script is downloaded #