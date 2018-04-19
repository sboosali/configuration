#!/bin/bash
set -e

########################################

ARGUMENTS="$@"

########################################

if [ ! -L ~/.config/argos ]; then
   echo 'removing non-symlink directory...'
   rm -fr ~/.config/argos
fi

ln -sf /home/sboo/configuration/config/argos ~/.config/argos

ls -l --color=auto ~/.config/argos

########################################

# -L file 
# true if file is a symbolic link

