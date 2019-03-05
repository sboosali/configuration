# [ ]

##################################################
{ path ? ./.
}:

##################################################
let
#------------------------------------------------#

/* Import overlays from « path ».
 *
 * An overlay may be at:
 *
 * - « path/_.nix »
 * - « path/_/default.nix »
 *
 * An overlay must have type « Attrset -> Attrset -> Attrset ».
 *
 * « importOverlays » has no dependencies (i.e. only « builtins »).
 *
 */

importOverlays = { path ? ./. }:

  let

  isStringOrPath = x:
    let
    t = builtins.typeOf x;
    in
    t == "string" || t == "path";

  in

  assert (isStringOrPath path);

  let

  importRelative     = n: import (toOverlayFile n);
  listDirectoryFiles = d: (builtins.attrNames (builtins.readDir d));

  toOverlayFile         = n: (path + ("/" + n));
  toOverlaySubdirectory = n: (path + ("/" + n + "/default.nix"));

  isNixFile      = n: (builtins.match ".*\\.nix" n != null);
  isNixDirectory = n: (builtins.pathExists (toOverlaySubdirectory n));
  isOverlay      = n: (isNixFile n || isNixDirectory n);

  overlays =

    (builtins.map importRelative
      (builtins.filter isOverlay
        (listDirectoryFiles path)));

  in

  assert (builtins.isList overlays && builtins.all builtins.isFunction overlays);

  overlays;

  # ^ e.g. « importOverlays ../overlays/ ».

  # ^ :: DirectoryPath -> List (Nixpkgs -> Nixpkgs -> Nixpkgs)

#------------------------------------------------#
in
##################################################

importOverlays { inherit path; }

##################################################
/*************************************************



************************************************



*************************************************/