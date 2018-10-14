##################################################
{ nixpkgs ? (import ./nixpkgs)
}:

##################################################
let

programs    = import ./programs.nix
 { inherit nixpkgs;
 };

environment = import ./environment.nix
 { inherit nixpkgs;
   inherit programs;
 };

in
##################################################

environment

##################################################
