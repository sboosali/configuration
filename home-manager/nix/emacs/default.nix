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

  self  = pkgs;
  super = pkgs;

};

#------------------------------------------------#
in
##################################################
{

  extraPackages = import ./packages.nix {

    inherit pkgs;
    inherit sbooUtilities emacsUtilities;

  };

  package = pkgs.emacs;

 #TODO overrides = import ./overrides.nix {};

}
##################################################