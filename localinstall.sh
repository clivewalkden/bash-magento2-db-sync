#!/usr/bin/env bash

homedir=$( getent passwd "$USER" | cut -d: -f6 )
dbsync=$homedir/.dbsync

echo -e " Installing locally"
tar c ./ | pv | tar x -C $dbsync
echo -e " Installation complete!"