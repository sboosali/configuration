##################################################
{ pkgs

, utilities
}:

#------------------------------------------------#

self: super:

##################################################
let
#------------------------------------------------#

configuration = import ./configuration.nix {

};

#------------------------------------------------#
in
##################################################

with utilities;

##################################################
{

 #-----------------------------#
 # Utilities ------------------#
 #-----------------------------#

 configurePackage = utilities.configureEmacsPackage self;

#fromRepository = utilities.fromEmacsRepository self;

 #-----------------------------#
 # Packages -------------------#
 #-----------------------------#

 edit-env = utilities.compileLocalFile "edit-env.el";

 #-----------------------------#

 hexrgb = utilities.compileEmacsWikiFile {
      name   = "hexrgb.el";
      sha256 = "18hb8brf7x92aidjfgczxangri6rkqq4x5d06lh41193f97rslm8";
      # date = 2019-03-09
  };

# hash mismatch in fixed-output derivation '/nix/store/gah8wylrh8hzhm6qb4j933c6gb4jkpw1-hexrgb.el':
#   wanted: sha256:1aj1fsc3wr8174xs45j2wc2mm6f8v6zs40xn0r4qisdw0plmsbsy
#   got:    sha256:18hb8brf7x92aidjfgczxangri6rkqq4x5d06lh41193f97rslm8

 #-----------------------------#

 awesome-tab = super.trivialBuild {

    pname   = "awesome-tab";
    version = "2.6";

    src = sbooUtilities.fetchFromGitHubJSON ./json/awesome-tab.json;

    meta.homepage = "https://github.com/manateelazycat/awesome-tab#README";
    meta.license  = lib.licenses.gpl3Plus;

 };

 #-----------------------------#

 better-registers = utilities.compileEmacsWikiFile {
      name   = "better-registers.el";
      sha256 = "sha256:05dlhhvd1m9q642gqqj6klif13shbinqi6bi72fldidi1z6wcqlh";
 };

 #-----------------------------#

 grab-and-drag = utilities.compileEmacsWikiFile {
      name   = "grab-and-drag.el";
      sha256 = "sha256:0lglm55vdlaqzsc6n7mm9ldcmlfq5rzg3fjkqqcpm02r231xnmcy";
 };

 #-----------------------------#

 magit = addBuildInputs super.magit
     [ pkgs.git
     ];

 #-----------------------------#

 magit-annex = addBuildInputs super.melpaPackages.magit-annex
     [ pkgs.git
       pkgs.haskellPackages.git-annex
     ];

 #-----------------------------#

 haskell-mode = self.melpaPackages.haskell-mode;

 #-----------------------------#
}
##################################################