##################################################
{ pkgs
, lib

, sboo
, applications
, xdgUtilities
}:

##################################################
let
#------------------------------------------------#

xbindkeys   = "xbindkeys";
xbindkeysrc = xdgUtilities.asXdgConfigPath "xbindkeys/xbindkeysrc.scm";

# xbindkeysrc = xdgUtilities.asXdgConfigPath "xbindkeys/.xbindkeysrc"
# xbindkeysrc = xdgUtilities.asXdgConfigPath "xbindkeys/xbindkeysrc.scm"

#------------------------------------------------#
in
##################################################
{
  #----------------------------#

 "nix/nix.conf".source = ../../../configs/nix/nix.conf;

  #----------------------------#

 "nixpkgs/home.nix".source   = ../../../configs/nixpkgs/home-noattrs.nix;
 "nixpkgs/config.nix".source = ../../../configs/nixpkgs/config.nix;

#"nixpkgs/overlays/default.nix".source = ../../../configs/nixpkgs/overlays/default.nix;

#"nixpkgs/home.nix".source   = ../../../configs/nixpkgs/home-noattrs.nix;
#"nixpkgs/home.nix".source   = ../../../configs/nixpkgs/home-attrs.nix;

  #----------------------------#

 "xfce4/terminal/terminalrc".source = ../../../themes/sboo/terminalrc;

 # "xfce4/terminal/terminalrc".source = ../../../themes/zenburn/terminalrc;

 # "xfce4/terminal/terminalrc".source = if sboo.dark
 #    then ../../../submodules/xfce4-terminal-colors-solarized/dark-high-contrast/terminalrc
 #    else ../../../submodules/xfce4-terminal-colors-solarized/light/terminalrc;

  #----------------------------#

 "cabal/config".text = import ../cabal/cabal-global.project.nix {
   inherit (pkgs) pass;
 };

#"stack/config.yaml".source = ../../../stack/config.yaml; #TODO

  #----------------------------#

 "xbindkeys/xbindkeysrc.scm".source   = ../../../xbindkeys/xbindkeysrc.scm;
 "xbindkeys/xbindkeysrc.scm".onChange = builtins.readFile ../../../xbindkeys/start;

# TODO: import a derivation
# XBINDKEYS="${xbindkeys}";
# XBINDKEYSRC="${xbindkeysrc}";

  #----------------------------#

 "gtk-3.0/settings.ini".source       = ../../gtk/3/settings.ini;
 "gtk-3.0/bookmarks".source          = ../../gtk/3/bookmarks;
 "gtk-2.0/gtkfilechooser.ini".source = ../../gtk/2/gtkfilechooser.ini;

  #----------------------------#

#TODO# "aspell/aspell.conf".source = ../../../configs/aspell/aspell.conf;

  # ^ Initialized via « aspell --lang=en dump config > aspell.conf ».
  #
  # "store your personal dictionaries wherever you want."
  #

  #----------------------------#

 "autostart/dropbox.desktop".source  = ../../desktop/dropbox.desktop;
 "autostart/firefox.desktop".source  = ../../desktop/firefox.desktop;
#TODO "autostart/terminal.desktop".source  = ../../desktop/terminal.desktop;
#"autostart/.desktop".source  = ../../desktop/.desktop;

  # ^ All desktop-entry-files under « ~/.config/autostart/ » are launched upon first login.

  #----------------------------#

#------------------------------------------------#
} // lib.optionalAttrs applications.emacs.autostart {

  "autostart/emacs.desktop".text = applications.emacs.desktop;
}
#------------------------------------------------#
 // lib.optionalAttrs applications.google-chrome.autostart {

  "autostart/google-chrome.desktop".text = applications.google-chrome.desktop;
}
#------------------------------------------------#
// {

}
##################################################

#"xfce4/xfconf/xfce-perchannel-xml/xsettings.xml" = ../../../xfce4/xsettings.xml;

#TODO onChange
