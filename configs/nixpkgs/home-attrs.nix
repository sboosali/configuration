
#------------------------------------------------#

# Build with:
#
#     $ home-manager -f ~/configuration/configs/nixpkgs/home-attrs.nix -A default build
#

##################################################
let
#------------------------------------------------#

homeFile =

  let
  value-dynamic = builtins.getEnv "SBOO_HOME_NIX";
  value-static  = ~/configuration/home-manager/nix/home.nix;
  in

  if   (builtins.isString value-dynamic && "" != value-dynamic)
  then value-dynamic
  else value-static;

#------------------------------------------------#

home = attrs: arguments@{ pkgs, ... }:

  import homeFile (arguments // attrs);

#------------------------------------------------#
in
##################################################
{

 default  = home { }; 

 linux    = home { platformLinux       = true; }; 
 darwin   = home { platformDarwin      = true; }; 

 small    = home { minimalInstallation = true; }; 
 full     = home { maximalInstallation = true; }; 

 emacs    = home { onlyEmacsPackages   = true; }; 
 programs = home { onlySystemPrograms  = true; };
 files    = home { onlyFiles           = true; }; 

}
##################################################

# Local Variables:
# compile-command: "home-manager -v -f ~/configuration/configs/nixpkgs/home-attrs.nix -A default build"
# End:
