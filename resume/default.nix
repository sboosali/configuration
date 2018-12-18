##################################################
{ nixpkgs ? <nixpkgs>
}:

##################################################
let

pkgs = (import nixpkgs {}).pkgs;

resume = import ./nix/package.nix
  { inherit (pkgs) stdenv texlive; };

in
##################################################
resume