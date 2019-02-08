##################################################
{ lib ? (import <nixpkgs> {}).pkgs.lib
}:

##################################################
let
##################################################

/* Parse a keysequence
 *
 */

 kbd = s:

   [ { key       = ;
       modifiers = [];
     }
   ];

##################################################
in
##################################################
rec {

  inherit kbd;

  xresources = import ./xresources { inherit lib; };

  #TODO# desktop = import ./desktop.nix {};

  mkDesktopEntry = import ./desktop/default.nix {}; 

}
##################################################