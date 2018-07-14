#!/bin/bash
set -o errexit
set -o nounset
########################################

MESSAGE="Usage: {{{ pinned FILENAME }}}"

FILENAME="${1:?${MESSAGE}}".desktop

DIRECTORIES=(/usr/share/applications /usr/local/share/applications ~/.local/share/applications)

PRESENCE=

########################################

for DIRECTORY in ${DIRECTORIES[@]}; do
  FILEPATH="$DIRECTORY/$FILENAME"
  if   test -f "$FILEPATH"
  then
       echo "[FILE EXISTS] $FILEPATH"
       PRESENCE="$FILEPATH"
  else
       :
  fi
done

if   test -z "$PRESENCE"
then
 echo "[ERROR] the desktop entry file FILENAME '$FILENAME' is not present in any directory ${DIRECTORIES[*]}"
 exit 1
else
 echo "[SUCCESS] this desktop entry file is (probably) being used by the desktop environment: {{{ $PRESENCE }}}"
 exit 0
fi
########################################
## NOTES

########################################