##################################################
{ lib ? (import <nixpkgs> {}).pkgs.lib
}:

##################################################
let


in
##################################################
rec {

  applications   = import ./applications.nix   { inherit lib application; };

  application    = import ./application.nix    { inherit lib desktop-entry; };

  desktop-entry  = import ./desktop-entry.nix  { inherit lib desktop-action; };

  desktop-action = import ./desktop-action.nix { inherit lib; };

}
##################################################
