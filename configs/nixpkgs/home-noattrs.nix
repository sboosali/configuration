#------------------------------------------------#

# Build with:
#
#     $ home-manager -f ~/configuration/configs/nixpkgs/home-noattrs.nix build
#

##################################################
arguments@
{ pkgs, ...}:

##################################################
let
#------------------------------------------------#

file =

  let
  value-dynamic = builtins.getEnv "SBOO_HOME_NIX";
  value-static  = ~/configuration/home-manager/nix/home.nix;
  in

  if   (builtins.isString value-dynamic && "" != value-dynamic)
  then value-dynamic
  else value-static;

#------------------------------------------------#
in
##################################################

import file arguments

##################################################

# Local Variables:
# compile-command: "home-manager -f ~/configuration/configs/nixpkgs/home-noattrs.nix build"
# End:
