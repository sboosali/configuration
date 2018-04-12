self: super: {}

/*

########################################
let

inherit (super.lib) attrValues;

in
########################################
let

utilities = rec {

 buildHaskellEnvironment = { compiler ? "default" }:
      let
        hp = if compiler == "default"
          then super.haskellPackages
          else super.haskell.packages.${compiler};
      in
        super.buildEnv {
         name  = "haskellEnvironment-${compiler}";
         paths = [
          hp.ghc
          hp.stack
          hp.hdevtools
        ];
 };

 haskellEnvironment = buildHaskellEnvironment {};

 haskellEnvironments = rec {
   ghc7103 = buildHaskellEnvironment { compiler = "ghc7103"; };
 };

# haskellCompilerAliases = {

 haskellCompilers = {

   default = haskellCompilers.ghc._8._2._2

   ghc._8._0._2 = "ghc802"
   
   ghc._8._2._2 = "ghc822"

   ghc._8._4._1 = "ghc841"
   
   ghc.HEAD = "ghcHEAD"

   ghcjs._7._10._3 = "ghcjs"   

   ghcjs.HEAD = "ghcjsHEAD"

    # { ghc."8"."2"."2" = "ghc822"; }

    #  _7 = {
    #    _10 = {
    #      _3 = {
    #      };
    #    };
    #  };

    #  _8 = {
    #    _0 = {
    #      _2 = {
    #      };
    #    };
    #    _2 = {
    #      _2 = {
    #      };
    #    };
    #    _4 = {
    #      _1 = {
    #      };
    #    };
    #  };
    # };

   ghc802 = [ "8.0" "8.0.2" ];


   ghc822 = [ "8.2" "8.2.2" ];

   ghc841 = [ "8.4" "8.4.1" ];

   integer-simple
     
HEAD|head
ghcHEAD

j|js
ghcjs

jHEAD|jhead|jsHEAD|jshead|ghcjshead
ghcjsHEAD





 };

};

in
########################################
# let 

# utilities = { inherit
# buildHaskellEnvironment
# haskellEnvironment
# haskellEnvironments
# ;};

# in

{
 inherit utilities
}
########################################

*/