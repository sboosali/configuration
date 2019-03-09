##################################################
self: super:

##################################################
# Imports ########################################
##################################################
let
#------------------------------------------------#

pkgs = super;

#------------------------------------------------#

utilities = import ./utilities.nix
  { inherit pkgs;
  };

#------------------------------------------------#

emacsPackageOverrides = import ./packages.nix
  { inherit pkgs;
    inherit utilities;
  };

#------------------------------------------------#

emacsApplicationOverrides = import ./emacs.nix self super;

#------------------------------------------------#

emacsApplications = emacsApplicationOverrides
  { overrides = emacsPackageOverrides;
  };

#------------------------------------------------#
in
##################################################

emacsApplications

##################################################