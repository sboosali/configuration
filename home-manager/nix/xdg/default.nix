##################################################
{ env
}:

##################################################
{

 configHome = "${env.HOME}/.config";
 dataHome   = "${env.HOME}/.local/share";
 cacheHome  = "${env.HOME}/.cache";

 # ^ the defaults.

##################################################

 configFile = import ./config.nix { };

 dataFile   = import ./data.nix { };

}
##################################################