
, minimal ? false;

inherit (lib) optionals;


theExecutables = neededExecutables ++ optionals minimal wantededExecutables;

# fails without
neededExecutables = [
 nix
 git
 tput
 lesspipe
 ];

# succeeds even without
wantededExecutables = [
 colordiff
 ];

in

theExecutables
