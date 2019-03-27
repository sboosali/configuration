##################################################
{ pkgs
}:

##################################################
let
#------------------------------------------------#

self  = pkgs;
super = pkgs;

#------------------------------------------------#
in
##################################################
let
#------------------------------------------------#

tryAttrs = object: fields:

  let

  go = field:
    tryAttr field object;

  in

  getFirst (builtins.map go fields);

#------------------------------------------------#

tryAttr = field: object:

  if   builtins.hasAttr field object
  then builtins.getAttr field object
  else null;

#------------------------------------------------#

getFirst = xs:

  let

  go = y: x:
    if   y == null && x != null
    then x
    else y;

    # ^ NOTE
    # « x != null » means: the current item is non-null.
    # « y == null » means: no previous item has been non-null.

  in

  builtins.foldl' go null xs;

#------------------------------------------------#
in
##################################################
let
#------------------------------------------------#

defaultGHC = GHC86;

#------------------------------------------------#

defaultGHCJS = self.haskell.compiler.ghcjs;

#------------------------------------------------#

GHC88 =

  tryAttrs self.haskell.compiler [
    "ghc882"
    "ghc881"
    "ghc880"
  ];

#------------------------------------------------#

GHC86 =

  tryAttrs self.haskell.compiler [
    "ghc864"
    "ghc863"
    "ghc862"
    "ghc861"
  ];

#------------------------------------------------#

GHC84 =

  tryAttrs self.haskell.compiler [
    "ghc844"
    "ghc843"
  ];

#------------------------------------------------#

GHC82 =

  tryAttrs self.haskell.compiler [
    "ghc822"
    "ghc821"
  ];

#------------------------------------------------#

GHC80 =

  tryAttrs self.haskell.compiler [
    "ghc802"
  ];

#------------------------------------------------#

GHC710 =

  tryAttrs self.haskell.compiler [
    "ghc7103"
    "ghc7103Binary"
  ];

#------------------------------------------------#

GHCs =

  [
    defaultGHC

    # GHC710
    # GHC80
    # GHC82
    GHC84
    GHC86

    defaultGHCJS
  ];

  # ^
  # first item in `paths` is the unqualified executable;
  # i.e. `ghc` is `ghc-8.4.4`.
  #
  # [problem] error "have the same priority ; use 'nix-env --set-flag priority NUMBER INSTALLED_PKGNAME' to change the priority of one of the conflicting packages"
  # even with `buildEnv.ignoreCollisions = true`.
  #
  # [solution] 
  #

#------------------------------------------------#

environment = super.buildEnv

 {
   name                  = "sboo-ghcs";
   paths                 = GHCs;
   ignoreCollisions      = true;
   extraOutputsToInstall = [ "out" "bin" "dev" "man" ];
 };

#------------------------------------------------#
in
##################################################

environment

##################################################
# Notes ##########################################
##################################################

# « buildEnv »:
#
# « https://github.com/NixOS/nixpkgs/blob/release-18.09/pkgs/build-support/buildenv/default.nix »
#
# buildEnv creates a tree of symlinks to the specified paths. 
#
# { name
# 
# , # The paths to symlink.
#   paths
# 
# , # Whether to ignore collisions or abort.
#   ignoreCollisions ? false
# 
# , # If there is a collision, check whether the contents and permissions match
#   # and only if not, throw a collision error.
#   checkCollisionContents ? true
# 
# , # The paths (relative to each element of `paths') that we want to
#   # symlink (e.g., ["/bin"]).  Any file not inside any of the
#   # directories in the list is not symlinked.
#   pathsToLink ? ["/"]
# 
# , # The package outputs to include. By default, only the default
#   # output is included.
#   extraOutputsToInstall ? []
# 
# , # Root the result in directory "$out${extraPrefix}", e.g. "/share".
#   extraPrefix ? ""
# 
# , # Shell commands to run after building the symlink tree.
#   postBuild ? ""
# 
# , # Additional inputs. Handy e.g. if using makeWrapper in `postBuild`.
#   buildInputs ? []
#
# }
#

##################################################

/*


foldl' :: (b -> a -> b) -> b -> [a] -> b


GHCs =
  [
    defaultGHC
    self.haskell.compiler.ghc7103               #TODO# removed from 19.03
    self.haskell.compiler.ghc802                #TODO# removed from 19.03
    self.haskell.compiler.ghc822 
    self.haskell.compiler.ghc843                # TODO check self.haskell.compiler ? ghc844
    #self.haskell.compiler.ghc844 
    self.haskell.compiler.ghc861               # TODO check self.haskell.compiler ? ghc861
    #self.haskell.compiler.ghc862

    defaultGHCJS
    # self.haskell.compiler.ghcjs710
    # self.haskell.compiler.ghcjs
  ];

*/