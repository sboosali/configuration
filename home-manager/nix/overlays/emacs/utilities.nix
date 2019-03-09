##################################################
{ pkgs
}:

##################################################
# Imports ########################################
##################################################
let
#------------------------------------------------#

inherit (pkgs)
        fetchurl fetchgit fetchFromGitHub stdenv;

#------------------------------------------------#

inherit (stdenv)
        lib mkDerivation;

#------------------------------------------------#
in
##################################################
# Exports ########################################
##################################################
rec {
#------------------------------------------------#

compileEmacsFiles = pkgs.callPackage ./builder.nix;

#------------------------------------------------#

compileLocalFile = name: 

  compileEmacsFiles {
    inherit name;

    src = ./elisp + ("/" + name);
  };

#------------------------------------------------#

compileEmacsWikiFile =

  { name
  , sha256
  , buildInputs ? []
  , patches     ? []
  }:

  compileEmacsFiles {
    inherit name buildInputs patches;

    src = fetchFromEmacsWiki { inherit name sha256; };
  };

#------------------------------------------------#

fetchFromEmacsWiki = pkgs.callPackage

  ({ fetchurl
   , name
   , sha256
   }:

  fetchurl {
    inherit sha256;

    url = "https://www.emacswiki.org/emacs/download/" + name;
  });

#------------------------------------------------#

withPatches = package: patches:

  lib.overrideDerivation package (attrs: { inherit patches; });

#------------------------------------------------#

/* Add programs as dependencies.
 *
 * e.g.
 *
 *     (addBuildInputs [ pkgs.git ] melpaPackages.magit)
 */

addBuildInputs = extraBuildInputs: package:
 
   package.overrideAttrs (old:
 
     {
       buildInputs = old.buildInputs ++ extraBuildInputs;
     });

#------------------------------------------------#
}
##################################################