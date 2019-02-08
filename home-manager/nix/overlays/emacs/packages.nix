########################################

pkgs:        # "parameters"

self: super: # overlay

########################################
# Imports ##############################
########################################
let

inherit (pkgs)
        fetchurl fetchgit fetchFromGitHub stdenv;

########################################

inherit (stdenv)
        lib;

########################################

utilities
  = (import ./utilities.nix) pkgs;

in
########################################
# Utilities ############################
########################################
let

# these utilities, unlike « ./utilities.nix »,
# don't import « pkgs ».
# thus, being simpler, they're kept separate.

addBuildInputs = extraBuildInputs: package:

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

withPatches = pkg: patches:

  lib.overrideDerivation pkg 
    (attrs: { inherit patches; });

in
########################################
# Packages #############################
########################################

with utilities;

########################################
let

# Packages Overridden and/or Introduced.

sboosaliEmacsPackages =
     requiredEmacsPackages
  // optionalEmacsPackages
     ;

# sboosaliEmacsPackages = lib.mergeAttrs
#   [ requiredEmacsPackages
#     optionalEmacsPackages
#   ];

########################################

requiredEmacsPackages = {

   #####################################

   # use-package = self.melpaBuild {
   #    pname = "use-package";
   #    version = "20180127.1411";
   #    src = ~/.emacs.d/submodules/use-package;
   #    recipe = fetchurl {
   #      url = "https://raw.githubusercontent.com/milkypostman/melpa/51a19a251c879a566d4ae451d94fcb35e38a478b/recipes/use-package";
   #      sha256 = "0d0zpgxhj6crsdi9sfy30fn3is036apm1kz8fhjg1yzdapf1jdyp";
   #      name = "use-package";
   #    };
   #    packageRequires = [ self.bind-key self.emacs ];
   #    meta = {
   #      homepage = "https://melpa.org/#/use-package";
   #      license = lib.licenses.free;
   #    };
   #  };

   #####################################

};

########################################

localEmacsPackages = {

   #####################################

   dante = self.melpaBuild {

      pname   = "dante";
      version = "0-pre";
      src     = ~/.emacs.d/submodules/dante;

      packageRequires = with self; [
        emacs        # emacs-26.1
        company      # company-0.9
        dash         # dash-2.12.0
        f            # f-0.19.0
        flycheck     # flycheck-0.30
        haskell-mode # haskell-mode-13.14
        lcr          # lcr-1.0
        s            # s-1.11.0
      ];

      recipe = ''
      (dante :repo    "jyp/dante"
             :fetcher github)
      '';

      meta.homepage = "https://github.com/jyp/dante#README";
      meta.license  = lib.licenses.gpl3Plus;
    };

   #####################################

};

########################################

melpaEmacsPackages = {

   #####################################

   dante = self.melpaBuild {
      pname = "dante";
      version = "20190129.2109";
      src = ~/.emacs.d/submodules/dante;
      recipe = fetchurl {
        url = "https://raw.githubusercontent.com/milkypostman/melpa/51a19a251c879a566d4ae451d94fcb35e38a478b/recipes/dante";
        sha256 = "0d0zpgxhj6crsdi9sfy30fn3is036apm1kz8fhjg1yzdapf1jdyp";
        name = "dante";
      };
      packageRequires = [ self.emacs ]; # TODO company 0.9 / dash 2.12.0 / emacs 25.1 / f 0.19.0 / flycheck 0.30 / haskell-mode 13.14 / lcr 1.0 / s 1.11.0
      meta = {
        homepage = "https://melpa.org/#/dante";
        license = lib.licenses.free;
      };
    };

   #####################################

};

########################################

optionalEmacsPackages = {

   #####################################

   hexrgb = self.compileEmacsWikiFile {
      name = "hexrgb.el";
      sha256 = "18hb8brf7x92aidjfgczxangri6rkqq4x5d06lh41193f97rslm8";
      # date = 2018-08-02T21:54:21-0400;
    };

   #####################################

   highlight-cl = self.compileEmacsWikiFile {
      name = "highlight-cl.el";
      sha256 = "0r3kzs2fsi3kl5gqmsv75dc7lgfl4imrrqhg09ij6kq1ri8gjxjw";
      # date = 2018-02-21T17:21:43-0800;
    };

   #####################################

    col-highlight = self.compileEmacsWikiFile {
      name = "col-highlight.el";
      sha256 = "0na8aimv5j66pzqi4hk2jw5kk00ki99zkxiykwcmjiy3h1r9311k";
      # date = 2018-02-21T17:21:33-0800

      buildInputs = [ self.vline ];
    };

   #####################################

   github-pullrequest = super.addBuildInputs super.github-pullrequest
     [ pkgs.git
     ];

   #####################################

   magithub = super.addBuildInputs super.magithub
     [ pkgs.git
       self.dash self.graphql self.treepy
     ];

   #####################################

   magit-annex = super.addBuildInputs super.magit-annex
     [ pkgs.git
       pkgs.haskellPackages.magit-annex
     ];

   #####################################

};

########################################
in
########################################

sboosaliEmacsPackages

##################################################
/* Notes *****************************************

e.g. « self » is « emacs26PackagesNg ».

  nix-repl> emacs26PackagesNg.dante.buildInputs
  [ «derivation /nix/store/9k63kadkr5znjssbqry2x4r63mbdk4vx-emacs-26.1.drv»                      # 
    «derivation /nix/store/gzg9nm016w0q8x6k43n9x5i18308w94g-texinfo-6.5.drv»                     # 
    «derivation /nix/store/s0vgpciyl8xn8nq7q7ppav94mybn6983-emacs-dash-20180910.1156.drv»        # 'dash
    «derivation /nix/store/7vd0pa1xxvgwh15bywqaqq0mca7n6f6s-emacs-s-20180406.108.drv»            # 's
    «derivation /nix/store/04pjfvs704k53i02rk3kq7a3gbd4x32k-emacs-f-20180106.122.drv»            # 'f
    «derivation /nix/store/6wy22kky8qdb6wz19dxmmmia735kpx2j-emacs-lcr-20180902.1219.drv»         # 'lcr
    «derivation /nix/store/ibdxkr8mjm5yhva24wvlzpdk59nlngh9-emacs-flycheck-20181018.321.drv»     # 'flycheck
    «derivation /nix/store/np55vrzlyyxs3wcb0b2c6vgzsc3crbks-emacs-haskell-mode-20180917.223.drv» # 'haskell-mode
  ]

*************************************************/
##################################################