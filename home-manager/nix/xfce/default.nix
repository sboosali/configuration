##################################################
{}:

##################################################


##################################################
rec {

  xfce4-desktop            = import xfce4-desktop.nix            {};
  xfce4-keyboard-shortcuts = import xfce4-keyboard-shortcuts.nix {};
  xfwm4                    = import xfwm4.nix                    {};
  xsettings                = import xsettings.nix                {};

}
##################################################
/*

<channel name="xfce4-desktop" version="1.0">
 <property ...>
 <property ...>
 ...
</channel>


*/
##################################################
