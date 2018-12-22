##################################################
{ sboo
, applications
}:

##################################################
{

 "fonts/iosevka".source    = ../../../fonts/iosevka/ttf;
 "fonts/iosevka".recursive = true;

 #################################################

 "applications/emacs.desktop".text = applications.emacs.desktop;

}
##################################################