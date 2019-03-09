##################################################
{ overrides
}:

#------------------------------------------------#
self: super:

##################################################
# Imports ########################################
##################################################
let
#------------------------------------------------#

pkgs = super;

#------------------------------------------------#

inherit (pkgs.stdenv)
        lib;

#------------------------------------------------#
in
##################################################
# Utilities ######################################
##################################################
let
#------------------------------------------------#

identityOverlay = (_eself: _esuper: {});

#------------------------------------------------#

/*
 *
 * Examples:
 *
 * >>> mkEmacsPackages { emacs = pkgs.emacs26; }
 *  :: Attrset
 *
 */

mkEmacsPackages = { emacs, overrides ? identityOverlay }:

  (self.emacsPackagesNgGen emacs).overrideScope (mkEmacsOverlay { inherit emacs overrides; });

#------------------------------------------------#

/*
 *
 * Examples:
 *
 * >>> mkEmacsOverlay { emacs = pkgs.emacs26; overrides = (eself: esuper: { ... }; ); }
 *  :: Overlay
 *
 */

mkEmacsOverlay = { emacs, overrides }:
                 eself: esuper:

  let

  myBaseEmacsPackages = eself.melpaPackages // {
      inherit emacs;
      inherit (eself) melpaBuild trivialBuild;
    };

  in

  lib.fix (lib.extends overrides (_eself: myBaseEmacsPackages));

# ^ NOTE: nested overlay.
#

# ^ « pkgs.lib.extends » has type « :: (a -> a -> a) -> (a -> a) -> (a -> a) ».

#------------------------------------------------#
in
##################################################
# Exports ########################################
##################################################
{
#------------------------------------------------#

 #-----------------------------#
 # Aliases 

 emacsPackages   = self.emacs26Packages;
 emacsPackagesNg = self.emacs26PackagesNg;
 emacs           = self.emacs26;

 #-----------------------------#
 # Emacs-26.1

 emacs26Packages   = self.emacs26PackagesNg;
 emacs26PackagesNg = mkEmacsPackages {
   emacs = self.emacs26;
   inherit overrides;
 };

 #-----------------------------#
 # Emacs (Jwiegley)

 emacs26Jwiegley =

 let

 site-start = ./elisp/site-start.el;

 in

 with pkgs;

 stdenv.lib.overrideDerivation

    (pkgs.emacs26.override {
    })

    (attributes: rec {

       name            = "${attributes.name}${versionModifier}";
       versionModifier = "-sboosali";

       postInstall = ''
       mkdir -p $out/share/emacs/site-lisp
       cp ${site-start} $out/share/emacs/site-lisp/site-start.el
       $out/bin/emacs --batch -f batch-byte-compile $out/share/emacs/site-lisp/site-start.el
       rm -rf $out/var
       rm -rf $out/share/emacs/${attributes.version}/site-lisp
       for srcdir in src lisp lwlib ; do
         dstdir=$out/share/emacs/${attributes.version}/$srcdir
         mkdir -p $dstdir
         find $srcdir -name "*.[chm]" -exec cp {} $dstdir \;
         cp $srcdir/TAGS $dstdir
         echo '((nil . ((tags-file-name . "TAGS"))))' > $dstdir/.dir-locals.el
       done
       '' + lib.optionalString stdenv.isLinux  /*TODO emacs.desktop */ ''
       '' + lib.optionalString stdenv.isDarwin ''
         mkdir -p $out/Applications
         mv nextstep/Emacs.app $out/Applications
       '';

    });

 #-----------------------------#

#------------------------------------------------#
}
##################################################