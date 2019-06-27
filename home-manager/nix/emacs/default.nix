##################################################
{ nixpkgs  ? <nixpkgs>
, config   ? {}
, overlays ? []
, pkgs     ? (import nixpkgs { inherit config overlays; })
, lib      ? pkgs.lib

, utilities ? (import ./utilities.nix { inherit pkgs; })
, options   ? { minimal = false; }
}:

##################################################
let
#------------------------------------------------#

#------------------------------------------------#
in
##################################################
{

  package = pkgs.emacs26;          # TODO pkgs.emacs.override { inherit (pkgs) imagemagick; }

  extraPackages = import ./packages.nix {

    inherit pkgs lib;
    inherit utilities options;

  };

  overrides = import ./overrides.nix {

    inherit pkgs lib;
    inherit utilities options;

  };

}
##################################################