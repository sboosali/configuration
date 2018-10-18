##################################################
{ pkgs

#, sboo

, utilities
}:
##################################################

with utilities;

##################################################
let

emacsPackages = epkgs: with epkgs; [

  use-package
  helm

  haskell-mode
  nix-mode

  projectile
  yasnippet

  (addBuildInputs [ pkgs.git ] melpaPackages.magit)

];

in
##################################################
emacsPackages
##################################################