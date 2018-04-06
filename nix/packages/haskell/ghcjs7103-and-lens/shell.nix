########################################
let

nixpkgs = import <nixpkgs> {};

in
########################################
let

default = import ./default.nix;

super = nixpkgs;

self  = default self super;

in
########################################

self

########################################
