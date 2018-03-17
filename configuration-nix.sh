#!/bin/bash
set -e
########################################

function absolute-path {
 echo $(cd $(dirname "$1"); pwd)/$(basename "$1")

 # versus `readlink`, which
 # /reads links/, which will be by cosntruction identical
}

function abort () {
  echo '$ ./configuration.sh [--help | --dry-run]'
  exit 1
}

########################################

NIXPKGS_STACKAGE=~/nixpkgs-stackage
# https://github.com/typeable/nixpkgs-stackage

NIXPKGS_OVERLAYS="$(absolute-path ./nix/overlays)"
# /home/sboo/.config/nixpkgs/overlays -> /home/sboo/configuration/nix/overlays

########################################

# info
echo
echo "$NIXPKGS_OVERLAYS/stackage-overlay.nix"
echo "->"
echo "$NIXPKGS_STACKAGE/default.nix"

# action
echo
ln -sf "$NIXPKGS_STACKAGE/default.nix" "$NIXPKGS_OVERLAYS/stackage-overlay.nix"

# info
echo
ls -l "$NIXPKGS_OVERLAYS/stackage-overlay.nix"

# test
echo
echo "[pkgs.haskell.packages.stackage]"
echo
nix-env -f '<nixpkgs>' -qaP -A haskell.packages.stackage.lts-107 | grep lens

########################################

########################################
