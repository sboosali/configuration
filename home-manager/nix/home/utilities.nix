##################################################
{ lib
}:
##################################################

rec {
 #################################################
 
 env = {
 
   HOME = builtins.getEnv "HOME";
 
 };
 
 #################################################
 
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
 
 #################################################

importOverlays = path:

  map (n: import (path + ("/" + n)))

      (filter (n: match ".*\\.nix" n != null
               || pathExists (path + ("/" + n + "/default.nix")))

              (attrNames (readDir path)));

 #################################################

}