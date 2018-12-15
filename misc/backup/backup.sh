#!/bin/bash
#set -e

########################################
# Description ##########################
########################################
# My backup script. Uses `rsync`.
#

########################################
# Usage ################################
########################################
#
# Displays a "dry-run", when given no arguments.
#
#   $ ./backup.sh
#   ...
#
# Otherwise is a wrapper around `rsync`. e.g.
#
#   $ ./backup.sh "/media/sboo/TOSHIBA EXT/backups"
#
# is like:
#
#   $ rsync -ah -v --exclude-from ./exclusions.txt /home/sboo/ "/media/sboo/TOSHIBA EXT/backups/YYYY-MM-DD_hh-mm-ss"
#
# where "/media/sboo/TOSHIBA EXT" is the filesystem location of my (plugged-in) External Hard-Drive.
#
#
##################################################
# Functions

function create-timestamp-directory () {
    # Create a directory, as a subdirectory of `"$1"`
    # named as the current timestamp, to seconds-resolution,
    # returning the name of the created directory.
    # Errors unless the directory was successfully created.

  PARENT_DIRECTORY="${1:-.}"
  TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
  TIMESTAMP_DIRECTORY="$PARENT_DIRECTORY/$TIMESTAMP"

  echo "$TIMESTAMP_DIRECTORY"
  mkdir -p "$TIMESTAMP_DIRECTORY"
  
}

########################################
# Constants

SOURCE="$HOME/"
#DEBUG SOURCE="$HOME/configuration"

CONFIGURATION_DIRECTORY="${CONFIGURATION:-/home/sboo/configuration}"

BACKUP_DIRECTORY="${CONFIGURATION_DIRECTORY}/backup"

EXCLUSIONS="${BACKUP_DIRECTORY}/exclusions.txt"

INCLUSIONS="${BACKUP_DIRECTORY}/inclusions.txt"

DEFAULT_BACKUP_DIRECTORY="/home/sboo/backups/rsync"

########################################
# Arguments

MEDIA_DIRECTORY="${1:-$DEFAULT_BACKUP_DIRECTORY}"

if   [ -z ${1+x} ]
     # ^ whether any arguments were given.
then DRY_RUN="--dry-run"
     # ^ if no DESTINATION is given, just print an rsync dry-run, against a stub destination.
else DRY_RUN=""
fi

shift
ARGUMENTS="$@"

########################################

# BACKUP_DIRECTORY
DESTINATION=$(create-timestamp-directory "${MEDIA_DIRECTORY}")

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
echo '----------------------------------------'
echo 'Passing these additional arguments to `rsync`...'
echo
echo "${ARGUMENTS}"
echo
echo
########################################

echo '----------------------------------------'
echo 'Size Before'
echo
du --total --dereference --human-readable "${DESTINATION}"
echo
echo

########################################

echo '----------------------------------------'
echo 'Copying...'
echo

time  rsync  -v  -ah  "$DRY_RUN"  --exclude-from "${EXCLUSIONS}"  $ARGUMENTS  "${SOURCE}"  "${DESTINATION}" 

echo
echo '[FINISHED SUCCESSFULLY]'
echo '----------------------------------------'
########################################

echo '----------------------------------------'
echo 'Size After'
echo
du --total --dereference --human-readable "${DESTINATION}"
echo
echo

########################################
## NOTES

# How to check if a variable is set in Bash?
#
#   if [ -z ${var+x} ]; then echo "var is unset"; else echo "var is set to '$var'"; fi
# 
# where ${var+x} is a parameter expansion which evaluates to nothing if var is unset, and substitutes the string x otherwise.
# 

# 
# rsync  -ah -v "$DRY_RUN"  --exclude-from "${EXCLUSIONS}"   --include-from "${INCLUSIONS}"  "${SOURCE}"  "${DESTINATION}"

########################################