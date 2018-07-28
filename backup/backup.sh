#!/bin/bash
set -e

# my backup script, uses `rsync`.

########################################
# Constants

SOURCE="$HOME/"
#TODO "/home/sboo/" -> "$HOME"
#DEBUG SOURCE="$HOME/configuration"

CONFIGURATION_DIRECTORY="${CONFIGURATION:-/home/sboo/configuration/backup}"

EXCLUSIONS="${CONFIGURATION_DIRECTORY}/exclusions.txt"

INCLUSIONS="${CONFIGURATION_DIRECTORY}/inclusions.txt"

DEFAULT_BACKUP_DIRECTORY="/home/sboo/backups/rsync"

########################################
# Arguments

DESTINATION="${1:-$DEFAULT_BACKUP_DIRECTORY}"

if   [ -z ${1+x} ]
     # ^ whether any arguments were given.
then DRY_RUN="--dry-run"
     # ^ if no DESTINATION is given, just print an rsync dry-run, against a stub destination.
else DRY_RUN=""
fi

########################################
echo
echo '----------------------------------------'
echo 'Excluding these (patterns of) files/directories:'
echo

cat  "${EXCLUSIONS}" | grep -v -e '^[[:space:]]*$'
# ^ skip blank lines

echo
echo '----------------------------------------'
echo 'Using this "exclusions-file":'
echo
echo "  ${EXCLUSIONS}"
echo
########################################
echo
echo '----------------------------------------'
echo 'Including these (patterns of) files/directories:'
echo

cat  "${INCLUSIONS}" | grep -v -e '^[[:space:]]*$'
# ^ skip blank lines

echo
echo '----------------------------------------'
echo 'Using this "inclusions-file":'
echo
echo "  ${INCLUSIONS}"
echo
########################################
echo '----------------------------------------'
echo 'This directory will be copied into:'
echo
echo "  ${DESTINATION}"
echo
echo '----------------------------------------'
echo 'Using this `rsync` version...'
echo
rsync --version
echo
echo
########################################

mkdir -p "${DESTINATION}"

echo '----------------------------------------'
echo 'Copying...'
echo

rsync  -ah -v "$DRY_RUN"  --exclude-from "${EXCLUSIONS}"   --include-from "${INCLUSIONS}"  "${SOURCE}"  "${DESTINATION}"

echo
echo '[FINISHED SUCCESSFULLY]'
echo '----------------------------------------'
########################################
## NOTES

# How to check if a variable is set in Bash?
#
#   if [ -z ${var+x} ]; then echo "var is unset"; else echo "var is set to '$var'"; fi
# 
# where ${var+x} is a parameter expansion which evaluates to nothing if var is unset, and substitutes the string x otherwise.
# 
########################################