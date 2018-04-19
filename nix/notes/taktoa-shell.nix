{ nixpkgs  ? import ./taktoa-nixpkgs.nix
, packages ? import ./taktoa-packages.nix
}: 

/*

https://ariya.io/2016/06/isolated-development-environment-using-nix

*/

########################################

# let default =
#  { nixpkgs  = import ./taktoa-nixpkgs.nix;
#             # custom/configured nixpkgs

#    packages = import ./taktoa-packages.nix;
#             # placeholder default
#  };

# in 

# ########################################

# { nixpkgs  ? default.nixpkgs
# , packages ? default.packages
# }: 






########################################
let

 inherit (nixpkgs) 
  
   # "import" functions
   buildEnv
  
   # "import" modules unqualified
   stdenv
   lib;
 
 # TODO add to config lib
 # nix-shell evaluation, return a nix-shell optimized environment.
 # shellAware = p: if lib.inNixShell then p.buildEnv else p;
 # shellAware = p: if lib.inNixShell then p.env else p;
 
 /*
 # username (doesn't matter);
 # packages available (i.e. their `/lib`, `/include`, `/doc`, ...);
 # executables available (i.e. their package's `/bin`) on your PATH;
 */
 home = rec
  { name        = "sboo";
    packages    = packages;
    executables = packages;  # TODO subset
  };
 
 # my home environment
 derivation = stdenv.mkDerivation {
   inherit (home) name;
   buildInputs = home.packages;
   env         = buildEnv 
                   { inherit (home) name;
                     paths = home.executables;
                   };
  };
 
 environment = derivation;
 # map shellAware packages

in
########################################

environment

########################################
