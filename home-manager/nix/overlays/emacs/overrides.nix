##################################################

self: pkgs: # overlay

##################################################
# Imports ########################################
##################################################
let
#------------------------------------------------#

inherit (pkgs)
        fetchurl fetchgit fetchFromGitHub stdenv;

#------------------------------------------------#

inherit (pkgs.stdenv)
        lib mkDerivation;

#------------------------------------------------#



#------------------------------------------------#
in
##################################################
# Utilities ######################################
##################################################
let

#------------------------------------------------#

in
##################################################
# "Exports" ######################################
##################################################
rec {
#------------------------------------------------#

mkEmacsOverlay = emacs:
                 esuper: eself: 

  let

  myBaseEmacsPackages = esuper.melpaPackages // {
      inherit emacs;
      inherit (esuper) melpaBuild trivialBuild;
    };

  in

  lib.fix (lib.extends myEmacsPackageOverrides (_eself: myBaseEmacsPackages));

# ^ NOTE: nested overlay.
# the `self` and `super` of `mkEmacsOverlay` shadow their namesakes
# of this file (`./overlays/emacs/utilities.nix`),
# (which is itself an overlay).

# ^ « pkgs.lib.extends » has type « :: (a -> a -> a) -> (a -> a) -> (a -> a) ».

#------------------------------------------------#

/*
 *
 */

mkEmacsPackages = emacs:

  (self.emacsPackagesNgGen emacs).overrideScope (mkEmacsOverlay emacs);

#------------------------------------------------#
}
##################################################
/*************************************************

>>> pkgs.emacsPackagesNgGen pkgs.emacs26



*************************************************/