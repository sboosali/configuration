##################################################
{ }:

##################################################
let
#-----------------------------------------------#

env = {
 
   HOSTNAME = builtins.getEnv "HOSTNAME";

};

#-----------------------------------------------#

applications = import ../applications {
};

#-----------------------------------------------#
in
##################################################
rec {

 #-----------------------------#

 paths = {
 };

 #-----------------------------#
 
 dark = false;

 # ^ Whether the system/global Color Scheme is dark (« true ») or light (« false »). 

 #-----------------------------#

 firstname = "Sam";

 lastname  = "Boosalis";

 name = builtins.concatStringsSep " "
 
   [ firstname lastname ];

 email = builtins.concatStringsSep ""
 
   [ firstname lastname "@" "gmail.com" ];

 #-----------------------------#
 
 keys.github = "${env.HOSTNAME}_git@github.com_id_rsa";

 #-----------------------------#

 files."home.nix" = builtins.toString ../home.nix;

 #-----------------------------#
 
 locations = {
 
   sanfrancisco.longitude = "38";
   sanfrancisco.latitude  = "122";
 
   boston.longitude = "42";
   boston.latitude  = "71";
 
 };
 
 #-----------------------------#

 lib = import ./lib.nix;

 #-----------------------------#
}
##################################################