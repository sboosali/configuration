##################################################
pkgs:

##################################################
self: super:

##################################################
let

inherit (pkgs)   fetchurl fetchgit fetchFromGitHub stdenv;
inherit (stdenv) lib mkDerivation;

in
##################################################
let
##################################################

withPatches = pkg: patches:

  lib.overrideDerivation pkg (attrs: { inherit patches; });

##################################################

compileEmacsFiles = pkgs.callPackage ./emacs/builder.nix;

##################################################

addBuildInputs = pkg: inputs:

  pkg.overrideAttrs (attrs: {
    buildInputs = attrs.buildInputs ++ inputs;
  });

##################################################

compileLocalFile = { directory ? ../../src/emacs }: name:

  compileEmacsFiles {
    inherit name;

    src = directory + ("/" + name); # TODO
  };

##################################################

fetchFromEmacsWiki = pkgs.callPackage ({ fetchurl, name, sha256 }:

  fetchurl {
    inherit sha256;

    url = "https://www.emacswiki.org/emacs/download/" + name;
  });

##################################################

compileEmacsWikiFile =

  { name, sha256
  , buildInputs ? [], patches ? []
  }:

  compileEmacsFiles {
    inherit name buildInputs patches;

    src = fetchFromEmacsWiki { inherit name sha256; };
  };

##################################################
in
##################################################
{

  inherit withPatches;
  inherit addBuildInputs;

  inherit fetchFromEmacsWiki;

  inherit compileEmacsFiles;
  inherit compileLocalFile;
  inherit compileEmacsWikiFile;

}
##################################################