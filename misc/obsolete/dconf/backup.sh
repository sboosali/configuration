#!/bin/bash
set -e

########################################

ARGUMENTS="$@"

########################################

dconf dump / > ./dconf/user.conf

echo
cat ./dconf/user.conf
echo

########################################
