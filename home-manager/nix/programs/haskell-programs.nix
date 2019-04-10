##################################################
{ self, lib }:

##################################################

with self; 

##################################################
let
#------------------------------------------------#



#------------------------------------------------#

#TODO: /nix/store/h32m37qqrf5hzjsmwv337lg2dnvggm8h-hpack-0.31.2/bin is not in the system search path.

#hpack = lib.generateOptparseApplicativeCompletions [ "hpack" ] self.hpack;

# ^ « generateOptparseApplicativeCompletions [ "exe" ] pkg »

#------------------------------------------------#
in
##################################################
[

 alex                           # Lexer-generator
 happy                          # Parser-generator
 hscolour                       # 

 stack                          # Build Tool

 ghcid                          # GHCi Daemon
 hasktags                       # TAGS-generator
 hpack                          #
#liquidhaskell                  # Haskell (Refinement-)Type-Checker

 git-annex                      # 

]
##################################################