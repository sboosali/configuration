#!/bin/bash
set -e
########################################

# installs all derivations in the Nix expression `shell.nix`,
# passing-through command-line-arguments. 

########################################

nix-env --show-trace  -f "./shell.nix"  -i '.*'  $*

########################################
