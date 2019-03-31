##################################################
{ pkgs

, xdg
}:

##################################################
let
#------------------------------------------------#

startxfce4 = ''/usr/bin/startxfce4'';

# ^ NOTE « startxfce4 » has been installed with
# « sudo apt install xubuntu-desktop », **not** from nixpkgs,

#------------------------------------------------#

xmodmap   = ''${pkgs.xorg.xmodmap}/bin/xmodmap'';

#setxkbmap = ''${pkgs.xorg.xmodmap}/bin/setxkbmap'';

#xbindkeys = ''${pkgs.xbindkeys}/bin/xbindkeys'';

#------------------------------------------------#

xbindkeysrc = ''${xdg.configHome}/xbindkeys/.xbindkeysrc'';

#------------------------------------------------#
in
##################################################

''
#!/bin/sh
#------------------------------------------------#

${xmodmap} ~/.Xmodmap || true

#------------------------------------------------#

exec ${startxfce4}
''