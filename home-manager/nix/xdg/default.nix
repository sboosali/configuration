##################################################
{ sboo
, applications
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

 configFile = import ./config.nix { inherit sboo applications; };
 dataFile   = import ./data.nix   { inherit sboo applications; };

 #-----------------------------#
}
##################################################