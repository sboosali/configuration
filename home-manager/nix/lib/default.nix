##################################################
{ lib ? (import <nixpkgs> {}).pkgs.lib
}:

##################################################
let
#------------------------------------------------#

/* Optional value
 *
 * Nix « optional b x » is like Haskell « return @[] » and « mzero @[] ».
 *
 */

option = b: x:
  assert (builtins.isBool b);

  if b then [x] else [];

#------------------------------------------------#
in
##################################################
let
#------------------------------------------------#

/* Parse a keysequence
 *
 */

 kbd = s:

   [ { key       = ;
       modifiers = [];
     }
   ];

#------------------------------------------------#
in
##################################################
rec {

  inherit kbd;

  xresources = import ./xresources { inherit lib; };

  #TODO# desktop = import ./desktop.nix {};
 
  mkDesktopEntry = import ./desktop/default.nix {}; 

}
##################################################