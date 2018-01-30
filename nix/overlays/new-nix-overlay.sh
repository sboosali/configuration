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
 super.callPackage x {};

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

/*

*/
EOF

echo
echo "$FILENAME"
echo
echo "$NIX_OVERLAY_TEMPLATE" > "$FILENAME"

########################################