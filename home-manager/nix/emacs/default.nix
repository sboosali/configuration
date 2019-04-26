##################################################
{ nixpkgs  ? <nixpkgs>
, config   ? {}
, overlays ? []
, pkgs     ? (import nixpkgs         { inherit config overlays; })
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

  package = pkgs.emacs26;

  extraPackages = import ./packages.nix {

    inherit pkgs lib;
    inherit utilities;

  };

  # overrides = import ./overrides.nix {

  #   inherit pkgs lib;
  #   inherit utilities;
  #   inherit options;

  # };

}
##################################################