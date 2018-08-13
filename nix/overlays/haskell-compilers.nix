self: super: 
########################################
let

ghcs = super.buildEnv
 {
   name             = "GHCs";
   ignoreCollisions = true;
   paths            = [
                        self.haskell.compiler.ghc843 
                        self.haskell.compiler.ghc861
                        self.haskell.compiler.ghcjs
                      ];
                      # ^
                      # first item in `paths` is the unqualified executable;
                      # i.e. `ghc` is `ghc-8.4.3`.
                      #
                      # [problem] error "have the same priority ; use 'nix-env --set-flag priority NUMBER INSTALLED_PKGNAME' to change the priority of one of the conflicting packages"
                      # even with `buildEnv.ignoreCollisions = true`.
                      #
                      # [solution] 
                      #
 };

sboo =
  {
    inherit ghcs;
  };

in
########################################
{

 sboo = (super.sboo or {}) // sboo;

}
########################################
# Notes ################################
########################################

# nix-repl> :i buildEnv { name = "ghcs"; ignoreCollisions = true; paths = [haskell.compiler.ghc843 haskell.compiler.ghc861]; }
#
# ^ /u/ElvishJerricco:
# \`nix-env\` treats two packages with the same name but different version suffixes as an upgrade operation. You'll probably need to use \`buildEnv\` to get the both:

########################################