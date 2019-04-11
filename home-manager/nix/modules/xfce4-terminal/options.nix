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

  Configuration.MiscAlwaysShowTabs        = types.bool;
  Configuration.MiscBell                  = types.bool;
  Configuration.MiscBordersDefault        = types.bool;
  Configuration.MiscCursorBlinks          = types.bool;
  Configuration.MiscCursorShape           = types.string; # e.g. « TERMINAL_CURSOR_SHAPE_BLOCK »
  Configuration.MiscDefaultGeometry       = types.string; # e.g. « 80x24 »
  Configuration.MiscInheritGeometry       = types.bool;
  Configuration.MiscMenubarDefault        = types.bool;
  Configuration.MiscMouseAutohide         = types.bool;
  Configuration.MiscToolbarDefault        = types.bool;
  Configuration.MiscConfirmClose          = types.bool;
  Configuration.MiscCycleTabs             = types.bool;
  Configuration.MiscTabCloseButtons       = types.bool;
  Configuration.MiscTabCloseMiddleClick   = types.bool;
  Configuration.MiscTabPosition           = types.string; # e.g. « GTK_POS_TOP »
  Configuration.MiscHighlightUrls         = types.bool;
  Configuration.MiscScrollAlternateScreen = types.bool;

  Configuration.ScrollingLines = types.positive # e.g. « 999999 »

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