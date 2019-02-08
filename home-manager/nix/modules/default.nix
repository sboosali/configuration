##################################################
{ # lib ? (import <nixpkgs> {}).pkgs.lib
}:

##################################################
let


in
##################################################
rec {

  applications  = import ./applications.nix  { inherit application; };

  application   = import ./application.nix   { inherit desktop-entry; };

  desktop-entry = import ./desktop-entry.nix {};

}
##################################################
