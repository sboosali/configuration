##################################################
{ pkgs
, utilities
}:

##################################################
{

 extraPackages = import ./packages.nix { inherit pkgs utilities; };

#package       = pkgs.emacs25;

}
##################################################