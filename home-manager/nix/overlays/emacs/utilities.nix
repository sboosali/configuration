########################################

pkgs:

########################################
# Imports
########################################
let

inherit (pkgs)
        fetchurl fetchgit fetchFromGitHub stdenv;

########################################

inherit (stdenv)
        lib mkDerivation;

in
########################################
# "Exports" ############################
########################################
{
########################################

compileEmacsFiles = pkgs.callPackage ./builder.nix; #TODO

########################################

compileLocalFile = name: 

  compileEmacsFiles {
    inherit name;
    src = ./emacs + ("/" + name);
  };

########################################

fetchFromEmacsWiki = pkgs.callPackage

  ({ fetchurl
   , name
   , sha256
   }:

  fetchurl {
    inherit sha256;
    url = "https://www.emacswiki.org/emacs/download/" + name;
  });

########################################

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

########################################
}
########################################