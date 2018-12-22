########################################
{ sboo
, applications
}:

########################################
{

  ######################################

 "cabal/config".text                 = import ../cabal/cabal-global.project.nix {};
#"stack/config.yaml".source = ../../../stack/config.yaml; #TODO

  ######################################

 "xbindkeys/.xbindkeysrc".source     = ../../../xbindkeys/xbindkeysrc;

  ######################################

 "gtk-3.0/settings.ini".source       = ../../gtk/3/settings.ini;
 "gtk-3.0/bookmarks".source          = ../../gtk/3/bookmarks;
 "gtk-2.0/gtkfilechooser.ini".source = ../../gtk/2/gtkfilechooser.ini;

  ######################################

 "autostart/dropbox.desktop".source  = ../../desktop/dropbox.desktop;
 "autostart/firefox.desktop".source  = ../../desktop/firefox.desktop;
#TODO "autostart/terminal.desktop".source  = ../../desktop/terminal.desktop;
#"autostart/.desktop".source  = ../../desktop/.desktop;

  # ^ All desktop-entry-files under « ~/.config/autostart/ » are launched upon first login.

  ######################################

##################################################
} // (if applications.emacs.autostart then {

  "autostart/emacs.desktop".text = applications.emacs.desktop;

##################################################
} else {}) // {



}
##################################################

#"xfce4/xfconf/xfce-perchannel-xml/xsettings.xml" = ../../../xfce4/xsettings.xml;