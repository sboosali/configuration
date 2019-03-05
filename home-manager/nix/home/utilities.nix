##################################################
{ lib
}:

##################################################
let
#-----------------------------------------------#



#-----------------------------------------------#
in
##################################################
rec {

 #-----------------------------------------------#

 env = {
 
   HOME     = builtins.getEnv "HOME";
   HOSTNAME = builtins.getEnv "HOSTNAME";

   PKG_CONFIG_PATH = builtins.getEnv "PKG_CONFIG_PATH";
   TERMINFO_DIRS   = builtins.getEnv "TERMINFO_DIRS";

 };

 #-----------------------------------------------#

 enable = attrset:
   attrset // { enable = true; };
 
 disable = attrset:
   attrset // { enable = false; };

 #-----------------------------------------------#
 
 addBuildInputs = extraBuildInputs: package:
 
   package.overrideAttrs (old:
 
     {
       buildInputs = old.buildInputs ++ extraBuildInputs;
     });
 
 # ^ e.g.
 #
 # (addBuildInputs [ pkgs.git ] melpaPackages.magit) 
 # 
 # equals:
 #
 # (melpaPackages.magit.overrideAttrs (old: {
 #     buildInputs = old.buildInputs ++ [ pkgs.git ];
 #  }))
 #
 
 #-----------------------------------------------#

}
##################################################