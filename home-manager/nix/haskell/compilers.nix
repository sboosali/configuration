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

defaultGHC = self.haskell.compiler.ghc843;

##################################################

defaultGHCJS = self.haskell.compiler.ghcjs710;

##################################################

GHCs =
  [
    defaultGHC
    self.haskell.compiler.ghc7103
    self.haskell.compiler.ghc802
    self.haskell.compiler.ghc822 
    self.haskell.compiler.ghc843 
    self.haskell.compiler.ghc861

    # defaultGHCJS
    # self.haskell.compiler.ghcjs710
    # self.haskell.compiler.ghcjs
  ];

  # ^
  # first item in `paths` is the unqualified executable;
  # i.e. `ghc` is `ghc-8.4.3`.
  #
  # [problem] error "have the same priority ; use 'nix-env --set-flag priority NUMBER INSTALLED_PKGNAME' to change the priority of one of the conflicting packages"
  # even with `buildEnv.ignoreCollisions = true`.
  #
  # [solution] 
  #

##################################################

environment = super.buildEnv
 {
   name                  = "GHCs";
   paths                 = GHCs;
   ignoreCollisions      = true;
   extraOutputsToInstall = [ "out" "bin" "dev" "man" ];
 };

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