#!/bin/bash
set -e
########################################

if [[ $# -ne 1 ]];
then
    echo
    echo '$ check-nix FILENAME'
    echo
    echo 'Parse FILENAME as a `nix` expression.'
    echo
    echo '# e.g.'
    echo '$ check-nix emacs.nix'
    echo
    exit 1
else
    FILENAME="$1"
fi

########################################

echo
nix-instantiate --parse "$FILENAME"
echo
nix-instantiate --eval "$FILENAME"
echo

