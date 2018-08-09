#!/bin/bash
##################################################

nix-prefetch-git ~/nixpkgs > ./nixpkgs/nixpkgs.json

##################################################
#
# echo $(cd ~/nixpkgs && git rev-parse --verify HEAD)
#
##################################################