##################################################
{ lib
}:

#------------------------------------------------#

assert (builtins.isAttrs lib);

##################################################
let
#------------------------------------------------#

options = import ./options.nix { inherit lib; };

#------------------------------------------------#
in
##################################################

/* Configuration for the <code>xfce4-terminal</code> terminal emulator.

For example, these <code>options</code>:

<code>
{

  Configuration.ColorCursor     = "#586e75";
  Configuration.ColorForeground = "#657b83";
  Configuration.ColorBackground = "#fdf6e3";
  Configuration.ColorPalette    = [ "#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642" "#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36" ]

  comments = [ "Solarized Light theme." ];

}
</code>

generate this config file:

<code>
[Configuration]
ColorCursor=#586e75
ColorForeground=#657b83
ColorBackground=#fdf6e3
ColorPalette=#eee8d5;#dc322f;#859900;#b58900;#268bd2;#d33682;#2aa198;#073642;#fdf6e3;#cb4b16;#93a1a1;#839496;#657b83;#6c71c4;#586e75;#002b36
# Solarized Light theme.
</code>

at this filepath:

<code>~/.config/xfce4/terminal/terminalrc</code>

Links:

https://docs.xfce.org/apps/terminal/advanced

 */
##################################################
rec {

  inherit options;
  

}
##################################################