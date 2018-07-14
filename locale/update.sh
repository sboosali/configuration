#!/bin/bash
set -e
########################################

##ARGUMENTS="$@"

MINE=~/configuration/locale/default-locale.sh

THEIRS=/etc/default/locale

########################################

echo '----------------------------------------'
echo
echo "[ MY NEW FILE]  ${MINE}"
echo "[THE OLD FILE] ${THEIRS}"
echo
echo '----------------------------------------'
echo
echo [DIFFING...] diff "${MINE}" "${THEIRS}"
echo
diff "${MINE}" "${THEIRS}" || true
echo
echo '----------------------------------------'

########################################

sudo cp "$@" "${MINE}" "${THEIRS}"

#? sudo localectl

########################################
# NOTES

# Usage
# =====
# 

########################################
