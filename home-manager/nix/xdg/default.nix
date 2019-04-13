##################################################
{ pkgs
, lib

, sboo
, applications
, xdgUtilities
}:

##################################################
let
#------------------------------------------------#

HOME = builtins.getEnv "HOME";

#------------------------------------------------#
in
##################################################
{
 #-----------------------------#

 configHome = "${HOME}/.config";
 dataHome   = "${HOME}/.local/share";
 cacheHome  = "${HOME}/.cache";

 # ^ the defaults.

#TODO check XDG_*_HOME envvars (here or later)?

 #-----------------------------#

 configFile = import ./config.nix { inherit pkgs lib; inherit sboo applications xdgUtilities; };
 dataFile   = import ./data.nix   { inherit sboo applications; };

 #-----------------------------#
}
##################################################