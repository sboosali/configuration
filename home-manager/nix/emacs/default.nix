##################################################
{ pkgs
, utilities
}:

##################################################
{

  extraPackages = import ./packages.nix { inherit pkgs utilities; };

# package       = pkgs.emacs26;

 #TODO overrides = import ./overrides.nix {};

}
##################################################