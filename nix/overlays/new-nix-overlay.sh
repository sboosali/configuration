#!/bin/bash
set -e
########################################

if [[ $# -ne 1 ]];
then
    echo '$ new-nix-overlay FILENAME'
    echo
    echo '# e.g.'
    echo '$ new-nix-overlay emacs'
    echo
    exit 1
else
    FILENAME="$1.nix"
fi

########################################

# (set a variable to a heredoc)
read -r -d '' NIX_OVERLAY_TEMPLATE <<EOF || true
self: super: 
########################################
let

# :: GitHub -> Derivation
github = x:
 super.callPackage (super.fetchFromGitHub x) {};

# :: FilePath -> Derivation
file = x:
 super.callPackage (import x) {};

in
########################################
{

/*

PACKAGE = file ../DIRECTORY;

PACKAGE = github {
  owner           = "";
  repo            = "";
  rev             = "";
  fetchSubmodules = true;
  sha256          = "?";
 };

*/

}
########################################

/* NOTES

# self: for requiring sibling packages
# super: for everything else (utilities, etc)
<p> = super.callPackage (super.importJSON ./<p>.json) { inherit (self) <q>; };

# the identity overlay
# ~ (const.const) empty 
identityOverlay = self: super: {}

# e.g.
$ nix-repl
> nixpkgs = import <nixpkgs> {}
> let super = { inherit (nixpkgs) callPackage fetchFromGitHub ...; }; self = import ./$FILENAME.nix self super; in self
{ emacs2nix = «derivation /nix/store/nxssrxd2qq2kkps34p2q16zzh83295kv-source.drv»; }

# e.g.
$ cat ./shell-$FILENAME.nix 
let
nixpkgs = import <nixpkgs> {}
super = { inherit (nixpkgs) callPackage fetchFromGitHub ...; }
self = import ./$FILENAME.nix self super
in
self
$ nix-eval ./shell-$FILENAME.nix 
{ $FILENAME = «derivation /nix/store/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-source.drv»; }

# e.g.
$ nix-prefetch-git 'https://github.com/ttuegel/emacs2nix' > emacs2nix.json

*/
EOF

echo
echo "$FILENAME"
echo
echo "$NIX_OVERLAY_TEMPLATE" > "$FILENAME"

########################################