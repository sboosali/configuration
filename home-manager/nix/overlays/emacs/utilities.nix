########################################

pkgs: self: super: 

########################################
# Imports
########################################
let

inherit (pkgs)
        fetchurl fetchgit fetchFromGitHub stdenv;

########################################

inherit (stdenv)
        lib mkDerivation;

########################################

myEmacsPackageOverrides
  = (import ./overrides.nix) pkgs; #TODO

in
########################################
# Utilities: Nix
########################################
let

addBuildInputs =  extraBuildInputs: package:

  package.overrideAttrs (old:
    { buildInputs = old.buildInputs ++ extraBuildInputs;
     }));

# ^
#
# e.g.
#
# (addBuildInputs [ pkgs.git ] melpaPackages.magit) 
# 
# equals:
#
# (melpaPackages.magit.overrideAttrs(old: {
#         buildInputs = old.buildInputs ++ [ pkgs.git ];
#       }))
#

########################################

in
########################################
# Utilities: Emacs
########################################
let

withPatches = pkg: patches:

  lib.overrideDerivation pkg 
    (attrs: { inherit patches; });

########################################

compileEmacsFiles = pkgs.callPackage ./emacs/builder.nix; #TODO

########################################

compileLocalFile = name: 

  compileEmacsFiles {
    inherit name;
    src = ./emacs + ("/" + name);
  };

########################################

fetchFromEmacsWiki = pkgs.callPackage ({ fetchurl, name, sha256 }:

  fetchurl {
    inherit sha256;
    url = "https://www.emacswiki.org/emacs/download/" + name;
  });

########################################

compileEmacsWikiFile

  = { name
    , sha256
    , buildInputs ? []
    , patches     ? []
    }:

  compileEmacsFiles {
    inherit name buildInputs patches;
    src = fetchFromEmacsWiki { inherit name sha256; };
  };

########################################

mkEmacsPackages = emacs:

  (self.emacsPackagesNgGen emacs).overrideScope (mkEmacsOverlay emacs);

########################################

mkEmacsOverlay = emacs:
                 super: self: 

  pkgs.lib.fix
    (pkgs.lib.extends
       myEmacsPackageOverrides
        (_: super.melpaPackages
             // { inherit emacs;
                  inherit (super) melpaBuild;
                  }));

# ^ NOTE: nested overlay.
# the `self` and `super` of `mkEmacsOverlay` shadow their namesakes
# of this file (`./overlays/emacs/utilities.nix`),
# (which is itself an overlay).

in
########################################
{


}
########################################