##################################################
{ pkgs
}:

##################################################
let

self  = pkgs;
super = pkgs;

haskellPackages = pkgs.haskellPackages;

in
##################################################
let

compilerPrograms = import ./compilers.nix
  { inherit pkgs;
  };

##################################################

packageList = import ./packages.nix
  { inherit pkgs haskellPackages;
  };

##################################################

packageEnvironment = super.buildEnv
 {
   name                  = "sboo-haskell-packages";
   paths                 = packageList;
   extraOutputsToInstall = [ "out" "bin" "dev" "doc" "devdoc" "man" "info" ];
 };

in
##################################################
{

  compilers = compilerPrograms;

  packages  = packageEnvironment;

}
##################################################