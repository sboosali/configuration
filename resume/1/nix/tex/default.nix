##################################################
{ #lib ? (import <nixpkgs> {}).pkgs.lib
}:

##################################################
let

tex = import ./tex.nix {};
cv  = import ./cv.nix  { inherit tex; };

in
##################################################
{

  inherit tex cv;

}
##################################################