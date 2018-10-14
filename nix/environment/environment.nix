##################################################
{ nixpkgs
, programs
}:

##################################################
let

inherit (nixpkgs) pkgs;

in
##################################################

pkgs.buildEnv
  {
      name                 = "sboosali-home-environment";

      paths                 = programs;
      pathsToLink           = [ "/" "/bin" "/lib" "/include" ];

      buildInputs           = programs;
      extraOutputsToInstall = [ "out" "dev" "doc" ];

  }
##################################################
