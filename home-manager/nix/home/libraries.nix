##################################################
{ pkgs
}:

##################################################
let

self  = pkgs;
super = pkgs;

in
##################################################
let

sbooLibraries = super.buildEnv
 {
   name                  = "sboo-libraries";
   paths                 = systemLibraries;
   #ignoreCollisions      = true;
   extraOutputsToInstall = [ "dev" "doc" "devdoc" "man" "info" ];
 };

##################################################

systemLibraries = with pkgs; [

 zlib
 zlib.static
 

];

in
##################################################
sbooLibraries
##################################################