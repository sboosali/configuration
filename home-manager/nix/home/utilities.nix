##################################################
{ pkgs
, lib
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

 fetchFromGitHubJSON = path:

   pkgs.fetchFromGitHub (lib.importJSON path);

 #-----------------------------------------------#

 tryString = x:

   let
   inherit (builtins.tryEval x) success value;
   in

   if success then value else "";

 #-----------------------------------------------#

 tryList = x:

   let
   inherit (builtins.tryEval x) success value;
   in

   if success then value else [];

 #-----------------------------------------------#

 tryAttrs = x:

   let
   inherit (builtins.tryEval x) success value;
   in

   if success then value else {};

 #-----------------------------------------------#

}
##################################################