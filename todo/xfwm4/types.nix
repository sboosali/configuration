##################################################
arguments@
{ lib   ? (import <nixpkgs> {}).lib
, utils ? (import ../utilities.nix)
}:

##################################################
# Imports ########################################
##################################################
let

inherit (lib.types) mkOptionType;

in
##################################################

with utils;

##################################################
# Types ##########################################
##################################################
rec {



}
##################################################
# Notes ##########################################
##################################################
/*

--------------------------------------------------

 */
##################################################