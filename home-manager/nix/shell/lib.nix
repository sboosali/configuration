##################################################
{ lib
}:

##################################################
let
#------------------------------------------------#

isStringOrPath = x:

  let

  t = builtins.typeOf x;

  in

  t == "string" || t == "path";

#------------------------------------------------#

startsWithSlash = s:

  builtins.substring 0 1 s == "/";

#------------------------------------------------#

hasBuiltinType = x:

  builtins.any (f: f x) [
    (builtins.isAttrs)
    (builtins.isBool)
    (builtins.isFloat)
    (builtins.isFunction)
    (builtins.isInt)
    (builtins.isList)
    (builtins.isNull)
    (builtins.isString)
  ];

#------------------------------------------------#

isPath = if builtins ? isPath then builtins.isPath else

  x:
  (! hasBuiltinType x) && startsWithSlash (builtins.toString x);

#------------------------------------------------#
in
##################################################
rec {
  #----------------------------------------------#

  #----------------------------------------------#

  /* Make a Colon-Separated string, from a list of « path »s and/or « string »s.
   *
   * Examples:
   *
   *     >>> makePath [ ~/.cabal/bin "~/.local/bin" ]
   *     "~/.cabal/bin:~/.local/bin"
   *
   * Notes:
   *
   * Renders the input as absolute filepath. 
   *
   * Calls « builtins.toString », because interpolating a path is different than interpolating a string.
   *
   * For example, « "${../../../scripts}" »:
   * - doesn't equal « /home/sboo/configuration/scripts »;
   * - does equals « "/nix/store/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-scripts" »;
   *
   */

  makePath = paths:

    assert (builtins.all isStringOrPath paths);

    let

    strings = builtins.map builtins.toString paths;

    in

    lib.strings.makeSearchPath "" strings;

  #----------------------------------------------#
}
##################################################