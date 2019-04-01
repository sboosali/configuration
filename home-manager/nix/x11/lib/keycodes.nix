##################################################
let
#------------------------------------------------#

keycodeAttrs = {

  "1" = 10;
  "2" = 11;
  "3" = 12;
  "4" = 13;
  "5" = 14;
  "6" = 15;
  "7" = 16;
  "8" = 17;
  "9" = 18;
  "0" = 19;

  #"" = ;

};

#------------------------------------------------#

keycodeOf = key:

  assert (builtins.isString key || builtins.isInt key);

  let

  keyString  = builtins.toString key;

  keyInteger =

    if   builtins.hasAttr keyString keycodeAttrs
    then builtins.getAttr keyString keycodeAttrs
    else null;

  in

  assert (builtins.isInt keyInteger || null == keyInteger);

  keyInteger;

#------------------------------------------------#

keycodeLHS = key:

  let

  kc = keycodeOf key;

  in

  if   null != kc
  then ''keycode ${kc}''
  else abort ''« keycodeLHS ${builtins.toString key} » — not a valid keysym.'';

#------------------------------------------------#
in
##################################################
{

  inherit keycodeAttrs;
  inherit keycodeOf;
  inherit keycodeLHS;

}
##################################################