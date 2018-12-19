##################################################
let

nixpkgs = import ./nixpkgs.nix;

inherit (import nixpkgs {})
        pkgs;

resume = (import ./resume.nix { inherit (pkgs) stdenv texlive; })
  {
    texFile = ./SamBoosalis.tex;
    clsFile = ./resume.cls;
  };

in
##################################################

resume