########################################

self: pkgs: # overlay

########################################
# Imports ##############################
########################################
let

inherit (pkgs)
        fetchurl fetchgit fetchFromGitHub stdenv;

########################################

inherit (pkgs.stdenv)
        lib mkDerivation;

########################################

inherit (pkgs.lib)
        fix extends;

########################################

myEmacsPackageOverrides =
  (import ./overrides.nix) pkgs; #TODO

in
########################################
# Utilities ############################
########################################
let

########################################

in
########################################
# "Exports" ############################
########################################
{

mkEmacsOverlay = emacs:
                 super: self: 

  let myBaseEmacsPackages = 
        super.melpaPackages // { inherit emacs;
                                 inherit (super) melpaBuild;
                               };
  in

  fix (extends
          myEmacsPackageOverrides
          (_self: myBaseEmacsPackages))

# ^ NOTE: nested overlay.
# the `self` and `super` of `mkEmacsOverlay` shadow their namesakes
# of this file (`./overlays/emacs/utilities.nix`),
# (which is itself an overlay).

# ^ « pkgs.lib.extends » has type « :: (a -> a -> a) -> (a -> a) -> (a -> a) ».

########################################

/*
 *
 */

mkEmacsPackages = emacs:

  (self.emacsPackagesNgGen emacs).overrideScope (mkEmacsOverlay emacs);

}
########################################
/*************************************************

>>> pkgs.emacsPackagesNgGen pkgs.emacs26



*************************************************/

