/* a package set

installable:

  nix-env -i  -f ./taktoa-nixpkgs.nix  -A userPkgs

testable:

  nix-shell ./taktoa-shell.nix -f ./taktoa-nixpkgs.nix  -A userPkgs

*/


########################################

let default = rec
 { nixpkgs  = import ./taktoa-nixpkgs.nix;
            # custom/configured nixpkgs

   packages = let 
              allPackages = nixpkgs.config.userPkgs;
                          # i.e. (import ./taktoa-config.nix) ??
              in
              allPackages;
            # install everything listed by default
 };

in 

########################################

{ packages ? default.packages
}:

/*
{ nixpkgs  ? default.nixpkgs;
, packages ? default.packages;  
}:
*/
    # NO, it's lexical scoping unlike elisp, knot must be manually tied, hence "cps"

########################################
# let

# in
########################################

packages
