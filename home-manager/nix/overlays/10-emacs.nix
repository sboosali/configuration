##################################################
self: super:

##################################################
let
#------------------------------------------------#

emacsApplications = import ./emacs self super;

#------------------------------------------------#
in
##################################################
# Exports ########################################
##################################################
{
#------------------------------------------------#

 inherit (emacsApplications)
         emacs
  #TODO  emacsPackages
         emacsPackagesNg
         ;

}
#------------------------------------------------#
##################################################