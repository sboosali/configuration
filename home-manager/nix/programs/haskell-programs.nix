##################################################
{ self, lib }:

##################################################
let
#------------------------------------------------#

#TODO: /nix/store/h32m37qqrf5hzjsmwv337lg2dnvggm8h-hpack-0.31.2/bin is not in the system search path.

#hpack = lib.generateOptparseApplicativeCompletions [ "hpack" ] super.hpack;

# ^ « generateOptparseApplicativeCompletions [ "exe" ] pkg »

#------------------------------------------------#
in
##################################################

with self; 

#------------------------------------------------#
[

 alex                           # Lexer-generator
 happy                          # Parser-generator
 hscolour                       # 

 stack                          # Build Tool
 intero                         # 

 ghcid                          # GHCi Daemon
 hasktags                       # TAGS-generator
 hpack                          #
#liquidhaskell                  # Haskell (Refinement-)Type-Checker

 pandoc                         # Pan-Document Converter.
 git-annex                      # 

]
#------------------------------------------------#
# Notes -----------------------------------------#
#------------------------------------------------#

/* pandoc = self.callPackage ./pandoc.nix { inherit (self) file-embed; };

$ cabal2nix -f+embed_data_files -f+static --jailbreak --no-check cabal://pandoc-2.7.2 > ./pandoc.nix

*/

#------------------------------------------------#
# EOF -------------------------------------------#
#------------------------------------------------#