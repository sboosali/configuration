##################################################
{ pkgs
, lib

, sboo
, xdg
, applications
}:

##################################################
let
#------------------------------------------------#

utilities = import ./lib.nix

 { inherit lib;
 };

#------------------------------------------------#

environmentVariables = import ./environment-variables.nix

 { inherit pkgs;
   inherit sboo xdg;
   shellUtilities = utilities;
 };

#------------------------------------------------#


#------------------------------------------------#
in
##################################################
{

  inherit utilities;
  inherit environmentVariables;

}
#################################################
/* 



 */
