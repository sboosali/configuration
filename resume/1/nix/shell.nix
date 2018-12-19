##################################################
let

pkgs = (import <nixpkgs> {}).pkgs;

inherit (import ./default.nix { inherit pkgs; })
        resume;

in
##################################################

resume.pdf