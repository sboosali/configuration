##################################################
# Pinned `nixpkgs`.
# 
# It's tracked in `nixpkgs.json`,
# generated from `nix-prefetch-git`,
# with optional configuration and overlays.
# 
# The relevant directories are:
# 
# - `./nix/nixpkgs/` 
# - `./nix/config/` (an `attrset`)
# - `./nix/overlays/` (a `list`)
# 
##################################################
let

readPrefetchGitJSON = p:
  (builtins.fetchGit
    (builtins.intersectAttrs { url = null; rev = null; }
      (builtins.fromJSON
        (builtins.readFile p))));

in
##################################################
let

nixpkgs  = readPrefetchGitJSON ./nixpkgs.json;

config   = import ../config;

overlays = import ../overlays;

in
##################################################

import nixpkgs { inherit config overlays; }

##################################################
