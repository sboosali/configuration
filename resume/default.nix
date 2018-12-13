##################################################
{ nixpkgs ? <nixpkgs>
}:

##################################################
let

pkgs = (import nixpkgs {}).pkgs;

resume = import ./resume.nix
  { inherit (pkgs) stdenv texlive; };

in
##################################################
resume