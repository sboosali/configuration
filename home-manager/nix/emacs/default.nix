##################################################
{ pkgs

, utilities
}:

##################################################
let
#------------------------------------------------#

sbooUtilities = utilities;

#------------------------------------------------#

emacsUtilities = import ./utilities.nix {

  inherit pkgs;

};

#------------------------------------------------#
in
##################################################
{

  package = pkgs.emacs26;

  extraPackages = import ./packages.nix {

    inherit pkgs;
    inherit sbooUtilities emacsUtilities;

  };

  overrides = import ./overrides.nix {

    inherit pkgs;
    inherit sbooUtilities emacsUtilities;

  };

}
##################################################