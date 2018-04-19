{ nixpkgs-with ? import <nixpkgs>
    # default/unconfigured nixpkgs repository

, secret ? {}
   # private/proprietary keys/passwords/etc.
   # not published or version controlled.
   # only some packages needs this. TODO assert?

}: 

########################################
let 

config-with = import ./taktoa-config.nix;

config  = config-with  { inherit secret; };
nixpkgs = nixpkgs-with { inherit config; };

in 
########################################

nixpkgs
