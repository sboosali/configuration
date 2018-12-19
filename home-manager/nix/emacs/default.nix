##################################################
{ pkgs
, utilities
}:

##################################################
{

  extraPackages = import ./packages.nix { inherit pkgs utilities; };

# package       = pkgs.emacs25;

 #TODO overrides = import ./overrides.nix {};

}
##################################################