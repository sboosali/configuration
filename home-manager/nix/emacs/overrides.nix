##################################################
{ pkgs

, sbooUtilities
, emacsUtilities

}:

#------------------------------------------------#

self: super:

##################################################
let
#------------------------------------------------#

configuration = import ./configuration.nix {

}:
  
#------------------------------------------------#
in
##################################################

with sbooUtilities;

#------------------------------------------------#

with emacsUtilities;

##################################################
{

  haskell-mode = self.melpaPackages.haskell-mode;

}
##################################################