##################################################
{ pkgs
, utilities
}:

##################################################
epkgs:

##################################################

with utilities;

##################################################

with epkgs; [

  use-package
  helm

  haskell-mode
  nix-mode

  projectile
  yasnippet

  (addBuildInputs [ pkgs.git ] melpaPackages.magit)

]
##################################################