##################################################
{ lib
}:

##################################################

rec {
 #################################################

 env = {
 
   HOME     = builtins.getEnv "HOME";
   HOSTNAME = builtins.getEnv "HOSTNAME";

   PKG_CONFIG_PATH = builtins.getEnv "PKG_CONFIG_PATH";
   TERMINFO_DIRS   = builtins.getEnv "TERMINFO_DIRS";

 };

 #################################################

 enable = attrset:
   attrset // { enable = true; };
 
 disable = attrset:
   attrset // { enable = false; };

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
  let
  importRelative        = n: import (toOverlayFile n);
  listDirectoryFiles    = d: (lib.attrNames (lib.readDir d));

  toOverlayFile         = n: (path + ("/" + n));
  toOverlaySubdirectory = n: (path + ("/" + n + "/default.nix"));

  isNixFile      = n: (lib.match ".*\\.nix" n != null);
  isNixDirectory = n: (lib.pathExists (toOverlaySubdirectory n));
  isOverlay      = n: (isNixFile n || isNixDirectory n);

  overlayFilesOrDirectories = listDirectoryFiles path;
  in

  (map importRelative
      (lib.filter isOverlay
        overlayFilesOrDirectories));

  # ^ e.g. « importOverlays ../overlays/ ».

  # ^ :: DirectoryPath -> List (Nixpkgs -> Nixpkgs -> Nixpkgs)

 #################################################

}