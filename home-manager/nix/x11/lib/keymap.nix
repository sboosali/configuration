##################################################
let
#------------------------------------------------#

keycodes = (import ./keycodes.nix);

inherit (keycodes) keycode;

#------------------------------------------------#

keysyms = (import ./keysyms.nix);

inherit (keysyms) keysym;

#------------------------------------------------#
in
##################################################
let
#------------------------------------------------#

keymap = theKeycode: theKeysyms:

  let

  lhs = keycodeOf theKeycode;
  rhs = keysymsOf theKeysyms;

  in

  if   null != kc
  then ''keycode ${kc}'';
  else abort ''« keycodeLHS ${builtins.toString key} » — not a valid keysym.'';

  ''keycode ${lhs} = ${rhs}'';

#------------------------------------------------#
in
##################################################



##################################################
