##################################################
{ lib
}:

#------------------------------------------------#

assert (builtins.isAttrs lib);

##################################################
let
#------------------------------------------------#

inherit (lib) types;
inherit (lib) generators;

#------------------------------------------------#
in
##################################################
let
#------------------------------------------------#

color = types.string;

#------------------------------------------------#

ansiColors8 = types.attrsOf {

  black  = types.submodule color;
  red    = types.submodule color;
  green  = types.submodule color;
  yellow = types.submodule color;
  blue   = types.submodule color;
  purple = types.submodule color;
  cyan   = types.submodule color;
  white  = types.submodule color;

};
#------------------------------------------------#

ansiColors16 = types.attrsOf {

  dull.black  = types.submodule color;
  dull.red    = types.submodule color;
  dull.green  = types.submodule color;
  dull.yellow = types.submodule color;
  dull.blue   = types.submodule color;
  dull.purple = types.submodule color;
  dull.cyan   = types.submodule color;
  dull.white  = types.submodule color;

  bright.black  = types.submodule color;
  bright.red    = types.submodule color;
  bright.green  = types.submodule color;
  bright.yellow = types.submodule color;
  bright.blue   = types.submodule color;
  bright.purple = types.submodule color;
  bright.cyan   = types.submodule color;
  bright.white  = types.submodule color;

};

#------------------------------------------------#
in
##################################################
let
#------------------------------------------------#

config = {

  Configuration.ColorCursor     = (types.submodule color);
  Configuration.ColorForeground = (types.submodule color);
  Configuration.ColorBackground = (types.submodule color);
  Configuration.ColorPalette    = types.either (types.listOf (types.submodule color))
                                ( types.either (types.submodule ansiColors8)
                                               (types.submodule ansiColors16)
                                );

};

#------------------------------------------------#

options = {

  inherit config;

  extraConfig = types.attrsOf (types.attrsOf _);

  comments = types.listOf types.string;

};

#------------------------------------------------#
in
##################################################

options

##################################################