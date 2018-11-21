##################################################
{}:

##################################################
let

GtkIconSizes = {

  gtk-menu                  = 32;
  gtk-small-toolbar         = 48;
  gtk-large-toolbar         = 48;
  gtk-dnd                   = 96;
  gtk-button                = 48;
  gtk-dialog                = 96;
  gtk-panel                 = 48;

  panel-applications-menu   = 48;
  panel-tasklist-menu       = 64;
  panel-menu                = 48;
  panel-directory-menu      = 48;
  panel-launcher-menu       = 48;
  panel-window-menu         = 48;
  panel-menu-bar            = 48;

  ev-icon-size-annot-window = 32;

  webkit-media-button-size  = 48;

};

in
##################################################
rec {

  Gtk.CanChangeAccels  = true;
  Gtk.FontName         = "Noto Sans 24";
  Gtk.ToolbarStyle     = "both-horiz";
  Gtk.ToolbarIconSize  = 9;
  Gtk.MenuImages       = true;
  Gtk.ButtonImages     = true;
  Gtk.MenuBarAccel     = "";
  Gtk.CursorThemeSize  = 36;
  Gtk.DecorationLayout = [["maximize" "minimize"] ["menu" "close"]];
  Gtk.IconSizes        = GtkIconSizes;

  Net.ThemeName        = "HighContrast";
  Net.IconThemeName    = "Paper";

  Xfce.LastCustomDPI   = 96;

  Xft.DPI              = 192;
  Xft.Antialias        = 0;
  Xft.HintStyle        = "hintslight";
  Xft.RGBA             = "vbgr";

}
##################################################
/*

<?xml version="1.0" encoding="UTF-8"?>
<channel name="xsettings" version="1.0">

  <property name="Net" type="empty">
    <property name="ThemeName" type="string" value="HighContrast"/>
    <property name="IconThemeName" type="string" value="Paper"/>
    <property name="DoubleClickTime" type="empty"/>
    <property name="DoubleClickDistance" type="empty"/>
    <property name="DndDragThreshold" type="empty"/>
    <property name="CursorBlink" type="empty"/>
    <property name="CursorBlinkTime" type="empty"/>
    <property name="SoundThemeName" type="empty"/>
    <property name="EnableEventSounds" type="empty"/>
    <property name="EnableInputFeedbackSounds" type="empty"/>
  </property>

  <property name="Xft" type="empty">
    <property name="DPI" type="int" value="192"/>
    <property name="Antialias" type="int" value="0"/>
    <property name="Hinting" type="empty"/>
    <property name="HintStyle" type="string" value="hintslight"/>
    <property name="RGBA" type="string" value="vbgr"/>
    <property name="Lcdfilter" type="empty"/>
  </property>

  <property name="Gtk" type="empty">
    <property name="CanChangeAccels" type="bool" value="true"/>
    <property name="ColorPalette" type="empty"/>
    <property name="FontName" type="string" value="Noto Sans 24"/>
    <property name="IconSizes" type="string" value="gtk-menu=32,32:gtk-small-toolbar=48,48:gtk-large-toolbar=48,48:gtk-dnd=96,96:gtk-button=48,48:gtk-dialog=96,96:gtk-panel=48,48:panel-applications-menu=48,48:panel-tasklist-menu=64,64:panel-menu=48,48:panel-directory-menu=48,48:panel-launcher-menu=48,48:panel-window-menu=48,48:panel-menu-bar=48,48:ev-icon-size-annot-window=32,32:webkit-media-button-size=48,48"/>
    <property name="KeyThemeName" type="empty"/>
    <property name="ToolbarStyle" type="string" value="both-horiz"/>
    <property name="ToolbarIconSize" type="int" value="9"/>
    <property name="MenuImages" type="bool" value="true"/>
    <property name="ButtonImages" type="bool" value="true"/>
    <property name="MenuBarAccel" type="string" value=""/>
    <property name="CursorThemeName" type="empty"/>
    <property name="CursorThemeSize" type="int" value="36"/>
    <property name="DecorationLayout" type="string" value="maximize,minimize:menu,close"/>
  </property>

  <property name="Xfce" type="empty">
    <property name="LastCustomDPI" type="int" value="96"/>
  </property>

</channel>

--------------------------------------------------

"gtk-menu=32,32:gtk-small-toolbar=48,48:gtk-large-toolbar=48,48:gtk-dnd=96,96:gtk-button=48,48:gtk-dialog=96,96:gtk-panel=48,48:panel-applications-menu=48,48:panel-tasklist-menu=64,64:panel-menu=48,48:panel-directory-menu=48,48:panel-launcher-menu=48,48:panel-window-menu=48,48:panel-menu-bar=48,48:ev-icon-size-annot-window=32,32:webkit-media-button-size=48,48";

gtk-menu=32,32
gtk-small-toolbar=48,48
gtk-large-toolbar=48,48
gtk-dnd=96,96
gtk-button=48,48
gtk-dialog=96,96
gtk-panel=48,48
panel-applications-menu=48,48
panel-tasklist-menu=64,64
panel-menu=48,48
panel-directory-menu=48,48
panel-launcher-menu=48,48
panel-window-menu=48,48
panel-menu-bar=48,48
ev-icon-size-annot-window=32,32
webkit-media-button-size=48,48

--------------------------------------------------

"maximize,minimize:menu,close";

"maximize,minimize" "menu,close"

[["maximize", "minimize"], ["menu", "close"]]

--------------------------------------------------

GtkIconSizes = {

  gtk-menu                  = [32, 32];
  gtk-small-toolbar         = [48, 48];
  gtk-large-toolbar         = [48, 48];
  gtk-dnd                   = [96, 96];
  gtk-button                = [48, 48];
  gtk-dialog                = [96, 96];
  gtk-panel                 = [48, 48];

  panel-applications-menu   = [48, 48];
  panel-tasklist-menu       = [64, 64];
  panel-menu                = [48, 48];
  panel-directory-menu      = [48, 48];
  panel-launcher-menu       = [48, 48];
  panel-window-menu         = [48, 48];
  panel-menu-bar            = [48, 48];

  ev-icon-size-annot-window = [32, 32];

  webkit-media-button-size  = [48, 48];

};

--------------------------------------------------

*/
##################################################
