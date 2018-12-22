##################################################
{ sboo
, applications
}:

##################################################
let

env = {

  HOME = builtins.getEnv "HOME";

};

in
##################################################
{

 configHome = "${env.HOME}/.config";
 dataHome   = "${env.HOME}/.local/share";
 cacheHome  = "${env.HOME}/.cache";

 # ^ the defaults.

##################################################

 configFile = import ./config.nix { inherit sboo applications; };

 dataFile   = import ./data.nix { inherit sboo applications; };

}
##################################################