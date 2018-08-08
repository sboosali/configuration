#!/bin/bash
set -eu
########################################
# Arguments

APPNAME="${1:-emacs}"

########################################
# Variables

FILENAME="${APPNAME}".desktop

FILEPATH="$HOME"/configuration/desktop-entry-files/"${FILENAME}"

SYMLINK="$HOME"/.local/share/applications/"${FILENAME}"

########################################
# Effects

echo '----------------------------------------'
echo
echo '[DesktopEntryFile=]'
echo "${FILEPATH}"
echo
cat "${FILEPATH}"
echo
echo '----------------------------------------'
echo
desktop-file-validate "${FILEPATH}"
echo
echo '----------------------------------------'
echo
ln -sf "${FILEPATH}" "${SYMLINK}"
echo
echo '----------------------------------------'
echo
ls -l "${SYMLINK}"
echo
echo '----------------------------------------'

########################################
# NOTES

# e.g.
#      ln -sf /home/sboo/.local/share/applications/emacs.desktop /home/sboo/configuration/desktop-entry-files/emacs.desktop

########################################