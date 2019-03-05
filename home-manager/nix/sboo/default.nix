##################################################
{ 
}:

##################################################
let
#-----------------------------------------------#

applications = import ../applications {};

#-----------------------------------------------#

env = {
 
   HOSTNAME = builtins.getEnv "HOSTNAME";

};

#-----------------------------------------------#
in
##################################################
rec {

 #----------------------------------------------#

 paths = {
 };
 
 #----------------------------------------------#
 
 colors.white = "rgb(255, 255, 255)";
 colors.black = "rgb(0,   0,   0)";
 
 #colors.darkorchid = "rgb(153,50,204)";
 #colors.lightgray  = "rgb()";
 
 #----------------------------------------------#
 
 locations = {
 
   sanfrancisco.longitude = "38";
   sanfrancisco.latitude  = "122";
 
   boston.longitude = "42";
   boston.latitude  = "71";
 
 };
 
 #----------------------------------------------#

 name = builtins.concatStringsSep " "
 
   [ firstname lastname ];

 email = builtins.concatStringsSep ""
 
   [ firstname lastname "@" "gmail.com" ];

 firstname = "Sam";

 lastname  = "Boosalis";

 # ^ TODO obfuscate more.

 #----------------------------------------------#
 
 keys.github = "${env.HOSTNAME}_git@github.com_id_rsa";

 #----------------------------------------------

 files."home.nix" = builtins.toString ../home.nix;

 #----------------------------------------------#

}
##################################################