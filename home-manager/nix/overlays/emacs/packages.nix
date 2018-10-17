########################################

pkgs:

self: super: 

########################################
# Packages: Overridden and/or Introduced.
########################################
let

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

########################################