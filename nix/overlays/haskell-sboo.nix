self: super: 
########################################
let

# imports...

inherit (super) lib;

in
########################################
let

sbooOverrides = sel: sup: 
  {

    mkDerivation
      = drv: sup.mkDerivation (drv //
         {
           jailbreak   = true; 
           doHaddock   = true;
           doCheck     = false;
           doBenchmark = false;
         });

  };

sbooLocalOverrides = sel: sup: 
  {

    Cabal                        = sup.Cabal_2_2_0_1;

    spiros                       = sel.callCabal2nix "spiros"                       ~/haskell/spiros                                  {};
    validation-warning           = sel.callCabal2nix "validation-warning"           ~/haskell/validation-warning                      {};

    enumerate                    = sel.callCabal2nix "enumerate"                    ~/haskell/enumerate/enumerate                     {};
    enumerate-function           = sel.callCabal2nix "enumerate-function"           ~/haskell/enumerate/enumerate-function            {};

    Vinyl                        = sel.callCabal2nix "Vinyl"                        ~/haskell/Vinyl                                   {};
    vinyl-profunctor             = sel.callCabal2nix "vinyl-profunctor"             ~/haskell/vinyl-profunctor                        {};

    memo                         = sel.callCabal2nix "memo"                         ~/haskell/Haskell-Memoize                         {};

    fltkhs                       = sel.callCabal2nix "fltkhs"                       ~/haskell/fltkhs                                  {};
    reflex-fltk                  = sel.callCabal2nix "reflex-fltk"                  ~/haskell/reflex-fltk                             {};

    kbd                          = sel.callCabal2nix "kbd"                          ~/haskell/kbd/kbd                                 {};
    genovation-control-pad       = sel.callCabal2nix "genovation-control-pad"       ~/haskell/genovation-control-pad                  {};

#    automation                  = sel.callCabal2nix "automation"                   ~/haskell/automation                              {};
    automation-signatures        = sel.callCabal2nix "automation-signatures"        ~/haskell/automation/automation-signatures        {};
    automation-for-x11-via-shell = sel.callCabal2nix "automation-for-x11-via-shell" ~/haskell/automation/automation-for-x11-via-shell {};
    xdotool                      = sel.callCabal2nix "xdotool"                      ~/haskell/automation/xdotool                      {};

#    dictation                   = sel.callCabal2nix "dictation"                    ~/haskell/dictation                               {};
    dictation-fsnotify           = sel.callCabal2nix "dictation-fsnotify"           ~/haskell/dictation/dictation-fsnotify            {};
    dictation-tools              = sel.callCabal2nix "dictation-tools"              ~/haskell/dictation/dictation-tools               {};
    dictation-server-host        = sel.callCabal2nix "dictation-server-host"        ~/haskell/dictation/dictation-server-host         {};
    dictation-server-guest       = sel.callCabal2nix "dictation-server-guest"       ~/haskell/dictation/dictation-server-guest        {};

#    project2nix                 = sel.callCabal2nix "project2nix"                  ~/haskell/project2nix                             {};

    reflex-core                  = sel.callCabal2nix "reflex-core"                  ~/haskell/reflex/reflex-core                      {};
    reflex                       = sel.callCabal2nix "reflex"                       ~/haskell/reflex/reflex                           {};

#    Expresso = sel.callCabal2nix "Expresso"                                        ~/haskell/Expresso                                {};
#    wxHaskell = sel.callCabal2nix "wxHaskell"                                      ~/haskell/wxHaskell                               {};

    cabal2nix                    = sel.callHackage "cabal2nix" "2.8.1"  {};
    hpack                        = sel.callHackage "hpack"     "0.29.6" {};
    # ^ for `cabal2nix`.

  };

haskellPackages = self.haskell.packages.ghc843.extend
  (self.lib.composeExtensions sbooLocalOverrides sbooOverrides);

sboo =
  {
    inherit haskellPackages;
    haskell.packages.ghc843 = haskellPackages;
  };

in
########################################
let

# inherit (self) makeWrapper nix nix-prefetch-scripts;
# haskellUtilities = super.haskell.lib;
# haskellPackages  = self.haskellPackages;

in
########################################
{

 sboo = (super.sboo or {}) // sboo;

 # haskellPackages = sboo.haskell.ghc;

 # cabal2nix = haskellUtilities.overrideCabal
 #  (haskellPackages.callHackage "cabal2nix" "2.8.1" {})
 #  (drv: {
 #    isLibrary = false;
 #    enableSharedExecutables = false;
 #    executableToolDepends = [ makeWrapper ];
 #    postInstall = ''
 #      exe=$out/libexec/${drv.pname}-${drv.version}/${drv.pname}
 #      install -D $out/bin/${drv.pname} $exe
 #      rm -rf $out/{bin,lib,share}
 #      makeWrapper $exe $out/bin/${drv.pname} \
 #        --prefix PATH ":" "${nix}/bin" \
 #        --prefix PATH ":" "${nix-prefetch-scripts}/bin"
 #      mkdir -p $out/share/{bash-completion/completions,zsh/vendor-completions,fish/completions}
 #      $exe --bash-completion-script $exe >$out/share/bash-completion/completions/${drv.pname}
 #      $exe --zsh-completion-script $exe >$out/share/zsh/vendor-completions/_${drv.pname}
 #      $exe --fish-completion-script $exe >$out/share/fish/completions/${drv.pname}.fish
 #    '';
 #  });
 #
 # ^ error: infinite recursion encountered
 
 # cabal2nix = self.sboo.haskell.ghc.cabal2nix;
 #
 # ^ error: infinite recursion encountered

}
########################################

# See
#    - http://mpickering.github.io/posts/2018-01-05-ghchead-nix.html
#

########################################