########################################
{ 
}:

########################################
{

 "cabal/config".text                 = import ../cabal/cabal-global.project.nix {};
#"stack/config.yaml".source = ../../../stack/config.yaml; #TODO

 "xbindkeys/.xbindkeysrc".source     = ../../../xbindkeys/xbindkeysrc;

 "gtk-3.0/settings.ini".source       = ../../gtk/3/settings.ini;
 "gtk-3.0/bookmarks".source          = ../../gtk/3/bookmarks;
 "gtk-2.0/gtkfilechooser.ini".source = ../../gtk/2/gtkfilechooser.ini;

 "autostart/dropbox.desktop".source  = ../../desktop/dropbox.desktop;

}
######################################

#"xfce4/xfconf/xfce-perchannel-xml/xsettings.xml" = ../../../xfce4/xsettings.xml;
