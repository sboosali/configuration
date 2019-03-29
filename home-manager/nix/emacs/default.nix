##################################################
{ nixpkgs  ? <nixpkgs>
, config   ? {}
, overlays ? []

, pkgs      ? (import nixpkgs         { inherit config overlays; })
, utilities ? (import ./utilities.nix { inherit pkgs;            })
}:

##################################################
let
#------------------------------------------------#

#------------------------------------------------#
in
##################################################
{

  package = pkgs.emacs26;

  extraPackages = import ./packages.nix {

    inherit pkgs;
    inherit utilities;

  };

  overrides = import ./overrides.nix {

    inherit pkgs;
    inherit utilities;

  };

}
##################################################