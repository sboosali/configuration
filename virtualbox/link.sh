#!/bin/bash
set -e
########################################

ARGUMENTS=

MY_CONFIG=~/configuration/virtualbox/config/VirtualBox.xml
THEIR_CONFIG=~/.config/VirtualBox/VirtualBox.xml

########################################

echo '----------------------------------------'
echo
echo "${MY_CONFIG}"
echo "${THEIR_CONFIG}"
echo
echo '----------------------------------------'
echo
if   diff "${MY_CONFIG}" "${THEIR_CONFIG}"
then
 echo
else
 echo
 echo '----------------------------------------'
 echo
 echo 'e.g...'
 echo
 echo '  $ diff <new> <old>'
 echo '  < ("new" line / addition / my edit                  ...)'
 echo '  ---'
 echo '  > ("old" line / deletion / last save by application ...)'
 echo '  ...'
 #echo '(red/left    arrows mean: )'
 #echo '(green/right arrows mean: )'
fi
echo
echo '----------------------------------------'

########################################

cp "$@"  "${MY_CONFIG}" "${THEIR_CONFIG}"

########################################
# NOTES

# Usage
# =====
# (~/configuration)$ virtualbox/link.sh -f

# Bash Idioms
# ===========
#
# - `diff ... || true` and/or `if diff ...` because:
#   `diff` fails (returns `1`) when the files differ.
#
# -

# Old
# ===
# ln -sf ~/configuration/virtualbox/config/VirtualBox.xml ~/.config/VirtualBox/VirtualBox.xml

########################################
