

rec {
##################################################

paths = {};

##################################################

colors.white = "rgb(255, 255, 255)";
colors.black = "rgb(0,   0,   0)";

colors.darkorchid = "rgb(153,50,204)";
#colors.lightgray = "rgb()";

##################################################

locations = {

  sanfrancisco.longitude = "38";
  sanfrancisco.latitude  = "122";

  boston.longitude = "42";
  boston.latitude  = "71";

};

##################################################

name = builtins.concatStringsSep " "

  [ "Sam" "Boosalis" ];

email = builtins.concatStringsSep ""

  ["sam" "boosalis" "@" "gmail" "." "com"];

# ^ TODO obfuscate more.

##################################################

keys.github = "SpirOS_git@github.com_id_rsa";

##################################################

}