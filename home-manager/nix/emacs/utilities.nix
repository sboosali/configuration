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
 *     (addBuildInputs melpaPackages.magit [ pkgs.git ])
 */

addBuildInputs = package: extraBuildInputs:

   package.overrideAttrs (old:
 
     {
       buildInputs = old.buildInputs ++ extraBuildInputs;
     });

#------------------------------------------------#

fromEmacsRepository = epkgs: { repo ? null }:

    assert (null == repo || builtins.isString repo);

    let

    epkgs =

      if repo == "elpa"        then epkgs.elpaPackages        else
      if repo == "melpa"       then epkgs.melpaPackages       else
      if repo == "melpaStable" then epkgs.melpaStablePackages else
      if repo == null          then epkgs                     else

      abort ''« fromRepository x » — « x » is « ${repo} », but must be one of: « null "elpa" "melpa" "melpaStable" »'';

    in

    epkgs;

#------------------------------------------------#

configureEmacsPackage = epkgs:

    { name
    , tools ? null, elisp ? null, package ? null, repo ? null
    }:

    assert (builtins.isString name);

    let

    repo' = fromEmacsRepository epkgs { inherit repo; };

    package' =

      if   package != null
      then package
      else repo'."${name}";

    tools' =

      if   tools != null
      then tools
      else [];

    elisp' =

      if   elisp != null
      then elisp
      else "";

    in

    addBuildInputs tools' package';

#------------------------------------------------#

}
##################################################