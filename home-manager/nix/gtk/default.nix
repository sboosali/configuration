##################################################
{ pkgs

, env
, sboo
}:

##################################################
{

  font.name    = "DejaVu Sans 28";               #TODO tweak size
  font.package = pkgs.dejavu_fonts;

  ################################################

  iconTheme.name    = "Adwaita";                 #TODO Paper
  iconTheme.package = pkgs.gnome3.adwaita-icon-theme;

  ################################################

  theme.name    = "Adapta-Nokto-Eta";            #TODO Paper
  theme.package = pkgs.adapta-gtk-theme;

}
##################################################