##################################################
{ nixpkgs  ? (import ./nixpkgs)
, overlays ? []                 # (import ./overlays)
, config   ? {}                 # (import ./config)

, pkgs ? (import nixpkgs { inherit overlays config; })

, ...
}:

##################################################

import ./home.nix {

  inherit pkgs;

};

##################################################