##################################################
{ pkgs

, sboo
, applications

}:
##################################################
let
#------------------------------------------------#

env = {

  HOME = builtins.getEnv "HOME";

};

#------------------------------------------------#
in
##################################################
let
#------------------------------------------------#

mkdir       = ''${pkgs.coreutils}/bin/mkdir'';
chmod       = ''${pkgs.coreutils}/bin/chmod'';

find        = ''${pkgs.findutils}/bin/find'';
xargs       = ''${pkgs.findutils}/bin/xargs'';

nix-shell   = "nix-shell"; #TODO# ''${pkgs.nix}/bin/nix-shell''
 #TODO3 or... keep "dynamic" (not lexical) to use the same nix that must be installed for home-manager to evaluate this very file
nix-store = "nix-store";

home-manager = "home-manager"; #TODO#? ''${config.programs.home-manager.path}/home-manager/home-manager.sh''

tar         = "tar"; #TODO# ''${pkgs.tar}/bin/tar'';
sed         = "sed"; #TODO# ''${pkgs.coreutils?}/bin/sed'';
grep        = "grep"; #TODO# ''${pkgs.??}/bin/grep'';

git         = ''${pkgs.git}/bin/git'';

xev         = "xev"; #TODO# ''${pkgs.xev}/bin/xev'';
xclip       = ''${pkgs.xclip}/bin/xclip'';
xdotool     = ''${pkgs.xdotool}/bin/xdotool'';
wmctrl      = ''${pkgs.wmctrl}/bin/wmctrl'';
xbrightness = ''${pkgs.xbrightness}/bin/xbrightness'';

#xmodmap    = ''${pkgs.xmodmap}/bin/xmodmap'';

xrandr               = ''${xrandr}/bin/xrandr'';
xrandr-invert-colors = ''${pkgs.xrandr-invert-colors}/bin/xrandr-invert-colors'';

xdg-open     = ''${pkgs.xdg_utils}/bin/xdg-open'';
# xdg-mime     = ''${pkgs.xdg_utils}/bin/xdg-mime'';
# xdg-settings = ''${pkgs.xdg_utils}/bin/xdg-settings'';

xprop       = ''${pkgs.xorg.xprop}/bin/xprop'';

redshift    = ''${pkgs.redshift}/bin/redshift'';

bat         = ''${pkgs.bat}/bin/bat'';

bfg         = ''${pkgs.bfg-repo-cleaner}/bin/bfg'';

#------------------------------------------------#

xbindkeys      = ''${pkgs.xbindkeys}/bin/xbindkeys'';
xbindkeys_show = ''${pkgs.xbindkeys}/bin/xbindkeys_show'';

#------------------------------------------------#

#TODO configure between [1] the package's program and [2] the vendored submodule's program with environment-variable like SBOO_HOME_MANAGER_CABAL

cabal = ''${pkgs.cabal-install}/bin/cabal'';

ghc        = ''${pkgs.ghc}/bin/ghc'';
ghci       = ''${pkgs.ghc}/bin/ghci'';
ghc-pkg    = ''${pkgs.ghc}/bin/ghc-pkg'';
haddock    = ''${pkgs.ghc}/bin/haddock'';
runghc     = ''${pkgs.ghc}/bin/runghc'';
runhaskell = ''${pkgs.ghc}/bin/runhaskell'';
hpc        = ''${pkgs.ghc}/bin/hpc'';
hp2ps      = ''${pkgs.ghc}/bin/hp2ps'';

# $ cd « pkgs.ghc »
# $ find -L ./bin -type f -executable
#
# ./bin/ghc
# ./bin/ghc-8.6.4
# ./bin/ghc-pkg
# ./bin/ghc-pkg-8.6.4
# ./bin/ghci
# ./bin/ghci-8.6.4
# ./bin/haddock
# ./bin/haddock-ghc-8.6.4
# ./bin/hp2ps
# ./bin/hpc
# ./bin/hsc2hs
# ./bin/runghc
# ./bin/runghc-8.6.4
# ./bin/runhaskell
#

#------------------------------------------------#

dhclient = "dhclient";

##################################################

XDG_DATA_HOME   = builtins.getEnv "XDG_DATA_HOME";
XDG_CONFIG_HOME = builtins.getEnv "XDG_CONFIG_HOME";
XDG_CACHE_HOME  = builtins.getEnv "XDG_CACHE_HOME";

#------------------------------------------------#

NIX_PROFILE = builtins.toString ~/.nix-profile;
NIXPKGS     = "${env.HOME}/nixpkgs";

#NixProfile = "${env.HOME}/.nix-profile";
#NixProfile = "${env.HOME}/.nix-profile";

##################################################

nixpkgs = builtins.mapAttrs (k: v: builtins.toString v) {

  sboo-clone    = ~/nixpkgs;
  unstable      = ~/.nix-defexpr/channels/nixpkgs-unstable;
  "nixos-18.09" = ~/.nix-defexpr/channels/nixos-18.09;

#''${NIX_PROFILE}/channels/nixpkgs-unstable'';

};

#------------------------------------------------#

xbindkeysrc = builtins.toString ~/configuration/xbindkeys/xbindkeysrc.scm;

#xbindkeysrc = builtins.toString ~/.config/xbindkeys/xbindkeysrc.scm;
#xbindkeysrc = builtins.toString ~/configuration/xbindkeys/xbindkeysrc.scm;

#------------------------------------------------#
in
##################################################
{

  #----------------------------------------------#

 d = "cd";

 #-----------------------------------------------#

 "d-"       = "cd -";

 "d.."      = "cd ..";
 "d..."     = "cd ../..";
 "d...."    = "cd ../../..";
 "d....."   = "cd ../../../..";
 "d......"  = "cd ../../../../..";
 "d......." = "cd ../../../../../..";

 #-----------------------------------------------#

 "dc" = ''cd ~/configuration && if type xterm-set-title; then xterm-set-title "config";  fi'';
 "de" = ''cd ~/.emacs.d      && if type xterm-set-title; then xterm-set-title "emacs";   fi'';

 "dh" = ''cd ~/haskell       && if type xterm-set-title; then xterm-set-title "haskell"; fi'';
 "dl" = ''cd ~/elisp         && if type xterm-set-title; then xterm-set-title "elisp";   fi'';
 "ds" = ''cd ~/src           && if type xterm-set-title; then xterm-set-title "src";     fi'';

 "dn" = ''cd ~/notes         && if type xterm-set-title; then xterm-set-title "notes";   fi'';

 "dr" = ''cd ~/Dropbox       && if type xterm-set-title; then xterm-set-title "Dropbox"; fi'';
#"dw" = ''cd ~/Downloads'';
 "dw" = ''cd ~/www           && if type xterm-set-title; then xterm-set-title "www";     fi'';
 "dm" = ''cd ~/media         && if type xterm-set-title; then xterm-set-title "media";   fi'';

 "dt" = ''cd ~/temporary'';
 "dk" = ''cd ~/backup'';

 "dx"  = ''cd ${NIXPKGS}'';
 "dxp" = ''cd ${NIX_PROFILE}'';

 "dxb" = ''cd ${NIX_PROFILE}/bin'';
 "dxe" = ''cd ${NIX_PROFILE}/etc'';
 "dxs" = ''cd ${NIX_PROFILE}/share'';
 "dxl" = ''cd ${NIX_PROFILE}/lib'';
 "dxi" = ''cd ${NIX_PROFILE}/include'';

#"dx" = ''cd ${NIX_PROFILE}/'';
#"dm" = ''cd ~/Documents'';

 #-----------------------------------------------#

 cd-mtg = ''cd ~/haskell/mtg && if type xterm-set-title; then xterm-set-title "mtg"; fi'';

 #-----------------------------------------------#

 cd-xdg-data   = ''cd ${XDG_DATA_HOME}'';
 cd-xdg-config = ''cd ${XDG_CONFIG_HOME}'';
 cd-xdg-cache  = ''cd ${XDG_CACHE_HOME}'';

 #-----------------------------------------------#

 cd-external-hard-drive = ''cd /media/sboo/toshiba-ext_*/ && df .'';

  #----------------------------------------------#

 c = "cat";

  #----------------------------------------------#

 o = "echo";

 #-----------------------------------------------#

  #----------------------------------------------#

 l = ''ls -alF'';

 #-----------------------------------------------#

 ll=''ls -alF'';
 la=''ls -A'';
 lc=''ls -CF'';

 # ^ « ls »

  #----------------------------------------------#

 r = "rm -f";

 # ^ « rm »

 #-----------------------------------------------#

 rr = "rm -fr";

 # rt  = "";
 # rta = "";

 #----------------------------------------------#

 md="${mkdir} -p";

 # ^ « mkdir »

 #-----------------------------------------------#

  #----------------------------------------------#

 c7="${chmod} 700";

 # ^ « chmod »

  #----------------------------------------------#

 sa   = ''. ~/.aliases'';
 sba  = ''. ~/.bash_aliases'';
 sbrc = ''. ~/.bashrc'';

 sbc-usr  = ''. /usr/share/bash-completion/bash_completion'';
 sbc-etc  = ''. /etc/bash_completion'';

 # ^ "s" prefix for "source".
 # 

  #----------------------------------------------#

 f = "${find}";

 #-----------------------------------------------#

 ff   = ''${find} -L . -type f'';
 fd   = ''${find} -L . -type d'';
 fx   = ''${find} -L . -type f -executable'';

 #-----------------------------------------------#

 "f." = ''${find} -L .'';
 f1   = ''${find} -L . -maxdepth 1'';
 f2   = ''${find} -L . -maxdepth 2'';
 f3   = ''${find} -L . -maxdepth 3'';

  #----------------------------------------------#

 p = "${grep} -i -n -C 0";

  # ^ « grep »

  # ^
  # -i, --ignore-case         ignore case distinctions
  # -l, --files-with-matches  print only names of FILEs containing matches
  # -n, --line-number         print line number with output lines

  # ^
  # « -C 0 » is a "trick" which prints dividors ("--") between matches.
  # « grep OPTIONS PATTTEN /dev/null FILENAME » is a hack which forces the filename to be printed,
  # but such interspered arguments, it can't be in the alias.

 #-----------------------------------------------#

  pr = "${grep} -i -n -C 0 --dereference-recursive";
  pv = "${grep} -i -n -C 0 --invert-match";
  pw = "${grep} -i -n -C 0 --word-regexp";
  pl = "${grep} -i -n -C 0 --line-regexp";

  # ^
  # -v, --invert-match        select non-matching lines
  # -w, --word-regexp         force PATTERN to match only whole words
  # -x, --line-regexp         force PATTERN to match only whole lines

 #-----------------------------------------------#

 pf = "${grep} -i -n -C 0 --fixed-strings";
 pe = "${grep} -i -n -C 0 --extended-regexp";
 pp = "${grep} -i -n -C 0 --perl-regexp";
 pg = "${grep} -i -n -C 0 --basic-regexp";

  # ^
  # -E, --extended-regexp     PATTERN is an extended regular expression (ERE)
  # -F, --fixed-strings       PATTERN is a set of newline-separated strings
  # -G, --basic-regexp        PATTERN is a basic regular expression (BRE)
  # -P, --perl-regexp         PATTERN is a Perl regular expression

  #----------------------------------------------#

 g = "${git}";

 #-----------------------------------------------#

 gl  = "${git} status";                                     # MNEMONIC: "«l»ist"
                                                            # NOTE "gs" would shadow GhostScript. 
 #-----------------------------------------------#

 "ga."  = "${git} add .";
 "ga.." = "${git} add ..";
 "gau"  = "${git} add -u";

 #-----------------------------------------------#

 "gc"  = "${git} commit";
 "gcm" = "${git} commit -m";
 "gc." = "${git} commit -m .";

 #-----------------------------------------------#

 gp   = "${git} push";
 gpac = "${git} add . && ${git} commit -m . && ${git} push";# MNEMONIC: «P»ush after «A»dding and «C»ommiting

 #-----------------------------------------------#

 gll  = "${git} pull";                                      # MNEMONIC: pu«l»«l»
 glrm = "${git} pull --rebase";                             # MNEMONIC: pu«l»l «R»ebase «M»aster
 glru = "${git} pull --rebase upstream master";             # MNEMONIC: pu«l»l «R»ebase «U»pstream

 #-----------------------------------------------#

 gd   = "${git} --no-pager diff";

 #-----------------------------------------------#

 gr   = "${git} remote";
 grau = "${git} remote add upstrem";                        # MNEMONIC: «R»emote «A»dd «U»pstream

 #-----------------------------------------------#

 gza = "${git} reset        HEAD --" ;                      # MNEMONIC: ctrl-«z» your «A»dd
 gzc = "${git} reset --soft HEAD~1";                        # MNEMONIC: ctrl-«z» your «C»ommit

 #-----------------------------------------------#

 gorc = "${git} status --porcelain | cut -d ' ' -f 3 | tr '\\n' ' '";
 #TODO ga   = "${git} amend";

  #----------------------------------------------#

 b = ''${bat}'';

  #----------------------------------------------#

 xv=''${xev} | ${grep} -A2 --line-buffered '^KeyRelease' | ${sed} -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p''; #TODO
 #  xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'

 # e.g.
 #     $ xev
 #     107 Print
 #     78 Scroll_Lock
 #     127 Pause

 #-----------------------------------------------#
 copy = ''${xclip} -selection clipboard'';
 xc   = ''${xclip} -selection clipboard'';
 xp   = ''${xclip} -selection clipboard -o'';
 #-----------------------------------------------#
 xd   = ''${xdotool}'';
 #-----------------------------------------------#
 xw   = ''${wmctrl}'';
 #-----------------------------------------------#
 open = ''${xdg-open}'';
 xo   = ''${xdg-open}'';
 #-----------------------------------------------#
 xb   = ''${xbrightness}'';
 xbr  = ''${xbrightness} 65535'';
 #-----------------------------------------------#
 xbk  = ''${xbindkeys}'';
 #-----------------------------------------------#
 #xm   = ''xmodmap''
 #-----------------------------------------------#

  #----------------------------------------------#

 screen-invert  = "${xrandr-invert-colors}";

 screen-white   = "${redshift} -x";

 screen-scarlet = "${redshift} -x && ${redshift} -O 1500";
 screen-red     = "${redshift} -x && ${redshift} -O 1000";
 screen-orange  = "${redshift} -x && ${redshift} -O 2000";
 screen-yellow  = "${redshift} -x && ${redshift} -O 3000";

 screen-day     = "${redshift} -x ; ${xrandr-invert-colors}";
 screen-warm    = "${redshift} -x && ${redshift} -O 9000";

 #-----------------------------------------------#

 xsi = "screen-invert";                                     # MNEMONIC {X}11-{I}nvert

 xsw = "screen-white";                                      # MNEMONIC {X}11-{W}hite
                                                            # NOTE     xw=wmctrl
 xsr = "screen-red";                                        # MNEMONIC {X}11-{R}ed
 xso = "screen-orange";                                     # MNEMONIC {X}11-{O}range
 xsy = "screen-yellow";                                     # MNEMONIC {X}11-{Y}ellow

 xsn = "screen-night";                                      # MNEMONIC {X}11-{N}ight
 xsd = "screen-day";                                        # MNEMONIC {X}11-{D}ay
 xsu = "screen-dusk";                                       # MNEMONIC {X}11-D{u}sk

 #-----------------------------------------------#

 red        = "redshift -O 1000";                           # one-shot, 1000K
 scarlet    = "redshift -O 1500";                           # one-shot
 orange     = "redshift -O 2000";                           # one-shot
 yellow     = "redshift -O 3000";                           # one-shot
 white      = "redshift -x";                                # 
 un-red     = "redshift -x";                                #

 #-----------------------------------------------#

# alias red ="xrandr --output 0x42 --crtc 0 --gamma "
# alias screen-night="screen-brighter--via-xdotool 20 ; ${redshift} -x ; ${redshift} -O 1000 ; xrandr-invert-colors"
# alias screen-night-dim="screen-brighter--via-xdotool 20 ; ${redshift} -x ; ${redshift} -O 1000 ; xrandr-invert-colors ; screen-dimmer--via-xdotool 10"
# alias screen-dusk="screen-brighter--via-xdotool 20 ; ${redshift} -x ; ${redshift} -O 2000 ; xrandr-invert-colors"

 #===============================================#

 h = "${cabal} new-build all";   # build {a}ll

 #-----------------------------------------------#

 cabal-run  = "LC_ALL=C.UTF-8 ${cabal} new-run";
 cabal-exec = "LC_ALL=C.UTF-8 ${cabal} new-exec --";

 cabal-build = "${cabal} new-build";
 cabal-test  = "${cabal} new-test --enable-tests";
 cabal-bench = "${cabal} new-bench --enable-benchmarks";

 cabal-typecheck = ''${cabal} new-build --ghc-options="-fno-code -fforce-recomp"'';

# cabal-     = "${cabal} new- ";
 #-----------------------------------------------#

 hc = "${cabal} new-configure";  # {c}onfigure
 hb = "${cabal} new-build";      # {b}uild
 hr = "${cabal} new-repl";       # {r}epl
 hx = "${cabal} new-run";        # e{x}ecute

 ht = "${cabal} new-test --enable-tests";             # {t}est
 hn = "${cabal} new-bench --enable-benchmarks";       # be{n}ch
 hd = "${cabal} new-haddock --enable-documentation";  # {d}ocumentation

 hz = "${cabal} new-clean";      # {z}(?)
 hu = "${cabal} new-update";     # {u}pdate

 #-----------------------------------------------#

 hca = "${cabal} new-configure all";
 hba = "${cabal} new-build all";
 hxa = "${cabal} new-run all -- ";

 hta = "${cabal} new-test --enable-tests all";
 hna = "${cabal} new-bench --enable-benchmarks all";
 hda = "${cabal} new-haddock --enable-documentation all";

 #-----------------------------------------------#

 "hc-" = "${cabal} new-configure -w ghc --ghc";          # {c}onfigure ghc (default)
 hc7   = "${cabal} new-configure -w ghc-7.10.3 --ghc";   # {c}onfigure ghc-{7} (latest)
 hc8   = "${cabal} new-configure -w ghc-8.6.1 --ghc";    # {c}onfigure ghc-{8} (latest)

 #TODO#hc = "${cabal} new-configure -w ghc --compiler=ghc";       # {c}onfigure ghc (default)

 #-----------------------------------------------#

 hcjs = "${cabal} new-configure -w ghcjs --ghcjs"; # {c}onfigure ghcjs

 #TODO#alias hcj7="cabal new-configure -w ghcjs-"
 #TODO#alias hcj8="cabal new-configure -w ghcjs-"

 #-----------------------------------------------#

 "hc-7.10" = "${cabal} new-configure -w ghc-7.10.3 --ghc"; # {c}onfigure ghc-{7}.{10}._
 "hc-8.00" = "${cabal} new-configure -w ghc-8.0.2 --ghc";  # {c}onfigure ghc-{8}.{0}._
 "hc-8.02" = "${cabal} new-configure -w ghc-8.2.2 --ghc";  # {c}onfigure ghc-{8}.{2}._
 "hc-8.04" = "${cabal} new-configure -w ghc-8.4.4 --ghc";  # {c}onfigure ghc-{8}.{4}._
 "hc-8.06" = "${cabal} new-configure -w ghc-8.6.1 --ghc";  # {c}onfigure ghc-{8}.{6}._

 #TODO# hc-8.08 = "${cabal} new-configure -w ghc-8.8. --ghc";  # {c}onfigure ghc-{8}.{}._

 #-----------------------------------------------#

 hc802 = "${cabal} new-configure -w ghc-8.0.2 --ghc";  # {c}onfigure ghc-{8}.{0}
 hc822 = "${cabal} new-configure -w ghc-8.2.2 --ghc";  # {c}onfigure ghc-{8}.{2}
 hc843 = "${cabal} new-configure -w ghc-8.4.3 --ghc";  # {c}onfigure ghc-{8}.{4}
 hc844 = "${cabal} new-configure -w ghc-8.4.4 --ghc";  
 hc861 = "${cabal} new-configure -w ghc-8.6.1 --ghc";  # {c}onfigure ghc-{8}.{6}
 hc862 = "${cabal} new-configure -w ghc-8.6.2 --ghc";  

 #TODOalias hc86="cabal new-configure -w ghc-8.6.2 --ghc"  # {c}onfigure ghc-{8}.{6}
 #hc88 = "${cabal} new-configure -w ghc-8.8. --ghc";  # {c}onfigure ghc-{8}.{}

 #-----------------------------------------------#

 hc80 = "hc802";  # {c}onfigure ghc-{8}.{0}
 hc82 = "hc822";  # {c}onfigure ghc-{8}.{2}
 hc84 = "hc844";  # {c}onfigure ghc-{8}.{4}
 hc86 = "hc862";  # {c}onfigure ghc-{8}.{6}

 #TODOalias hc86="cabal new-configure -w ghc-8.6.2 --ghc"  # {c}onfigure ghc-{8}.{6}
 #hc88 = "${cabal} new-configure -w ghc-8.8. --ghc";  # {c}onfigure ghc-{8}.{}

 #-----------------------------------------------#

 "hc-7-thru-8-build" = "hc8 && time hba ; hc7 && time hba ; hc80 && time hba ; hc82 && time hba ; hc84 && time hba ; hc86 && time hba";

 "hc-7-thru-8-test" = "hc8 && time hta ; hc7 && time hta ; hc80 && time hta ; hc82 && time hta ; hc84 && time hta ; hc86 && time hta";

 "hc-7-thru-8-make" = "hc8 && time make ; hc7 && time make ; hc80 && time make ; hc82 && time make ; hc84 && time make ; hc86 && time make";

 #-----------------------------------------------#

 hnba = ''${nix-shell} --run "${cabal} new-build all"'';

 #===============================================#

 hm = ''${home-manager}'';

 #-----------------------------------------------#

 help-home-manager = ''${home-manager} --help'';

 #===============================================#

 bfg-force-remove = ''${bfg} --no-blob-protection --delete-files '';

 #===============================================#

 nm  = ''time ${home-manager} -f ${sboo.files."home.nix"}'';

 nmb = ''time (cd ~/configuration ; ${home-manager} -v -f ${builtins.toString ~/configuration/home-manager/nix/home.nix} build)'';
 nmw = ''time (cd ~/configuration ; ${home-manager} -v -f ${builtins.toString ~/configuration/home-manager/nix/home.nix} switch)'';

 # ^ NOTE « -v » passes « --show-trace ».

 nmg = ''${home-manager} generations'';
 nmp = ''${home-manager} packages'';

 nr=''sboo-nix-repl'';

 #----------------------------------------------#

 nix-reverse-dependencies = ''${nix-store} --query --referrers'';

 #===============================================#

 sboo-home-manager-build  = ''${home-manager} -f ${sboo.files."home.nix"} build'';
 sboo-home-manager-switch = ''${home-manager} -f ${sboo.files."home.nix"} switch && systemctl --user daemon-reload'';

 sboo-home-manager-switch-xbindkeys = ''${home-manager} -f ${sboo.files."home.nix"} switch && systemctl --user daemon-reload && systemctl --user start xbindkeys && systemctl --user status xbindkeys'';

 #-----------------------------------------------#

 sboo-home-manager-build--cloned  = ''NIX_PATH=nixpkgs=${nixpkgs.sboo-clone} ${home-manager} -f ${sboo.files."home.nix"} build'';
 sboo-home-manager-switch--cloned = ''NIX_PATH=nixpkgs=${nixpkgs.sboo-clone} ${home-manager} -f ${sboo.files."home.nix"} switch'';

 #-----------------------------------------------#

 sboo-home-manager-build--nixpkgs-unstable  = ''NIX_PATH=nixpkgs=${nixpkgs.unstable} ${home-manager} -f ${sboo.files."home.nix"} build'';
 sboo-home-manager-switch--nixpkgs-unstable = ''NIX_PATH=nixpkgs=${nixpkgs.unstable} ${home-manager} -f ${sboo.files."home.nix"} switch'';

 #-----------------------------------------------#

 sboo-haskell-print-platform = ''${ghci} -e ":unset +t" -e "putStrLn System.Info.arch" -e "putStrLn System.Info.os" 2>/dev/null'';

 # e.g.:
 #
 #   $ sboo-haskell-print-platform
 #
 #     x86_64
 #     linux

 #===============================================#

 sboo-apt-install = ''sudo apt -y install'';

 #-----------------------------------------------#

  #----------------------------------------------#

 #-----------------------------------------------#


# « ssh » commands:
#
# * « ssh-add »
# * « ssh-key  »
# * « ssh-ident »
#

# ssh-add github
# passwd same as github.com
#
# ssh-key with passphrase, with ssh-ident:

  #----------------------------------------------#

 sboo-source-cabal-bash-completion = ''source ${builtins.toString ~/src/sboo/cabal/cabal-install/bash-completion/cabal}'';

  #----------------------------------------------#

  sboo-xbindkeys-start  = ''${xbindkeys} --poll-rc -fg ${xbindkeysrc}'';
  sboo-xbindkeys-stop   = ''killall xbindkeys'';
  sboo-xbindkeys-reload = ''killall -HUP xbindkeys'';

  sboo-xbindkeys-test   = ''${xbindkeys} --show --verbose --nodaemon -fg ${xbindkeysrc}'';
  sboo-xbindkeys-list   = ''pgrep -x xbindkeys'';
  sboo-xbindkeys-config = ''${xbindkeys_show} -fg ${xbindkeysrc}'';

  # ^ « pgrep -x »:
  #
  #   • means an exact process-name match.

  #----------------------------------------------#

  systemd-restart = ''systemctl --user daemon-reload'';

  systemd-xbindkeys-start = ''systemctl --user daemon-reload && systemctl --user start xbindkeys'';
  systemd-xbindkeys-stop  = ''systemctl --user stop xbindkeys'';

  #----------------------------------------------#

  #----------------------------------------------#

  #----------------------------------------------#

  #----------------------------------------------#

  #----------------------------------------------#

  # « tar »:
  #
  # • « -x » — extract (a.k.a un-archive / de-compress).
  # • « -c » — compress (a.k.a archive / compress).
  # • « -v » — verbose (prints files).
  # • « -f FILEPATH » — take a file.
  #

  untargz = "${tar} -v -x --gzip -f";

  # ^ Uncompress and Extract a « .tar.gz »

  untarbz2 = "${tar} -v -x --bzip2 -f";

  # ^ Uncompress and Extract a « .tar.bz2 »

  untarxz = "${tar} -v -x --xz -f";

  # ^ Uncompress and Extract a « .tar.xz »

  untarball = "${tar} -v -x -f";

  # ^ Uncompress and Extract (infer compression from file-extension).

  #----------------------------------------------#

 yt = ''${pkgs.youtube-dl}/bin/youtube-dl --ignore-errors --write-info-json --write-thumbnail'';

 # « youtube-dl » options:
 #
 # * « --ignore-errors » — Continue on download errors, for example to skip unavailable videos in a playlist.
 # * « --write-info-json » — Write video metadata to a .info.json file.
 # * « --write-thumbnail » — Write thumbnail image to disk. 
 # * «  » — 
 # * «  » — 

#yt = ''${pkgs.youtube-dl}/bin/youtube-dl -f 22'';

 #TODO melpa2nix = ''${pkgs.emacs2nix}/bin/melpa2nix'';

  #----------------------------------------------#

 alert = ''notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')"'';

 # ^ « notify-send »:
 #
 # for long running commands. Usage: « sleep 10; alert "OPTIONAL MESSAGE" »

 sboo-git-status-subdirs = ''find . -maxdepth 1 -mindepth 1 -type d -exec sh -c '(echo {} && cd {} && git status -s && echo)' ';' '';

 #----------------------------------------------#

 sboo-cabal-update = ''time (${cabal} new-update "hackage.haskell.org" && ${cabal} "new-update stackage-lts-13.12" && ${cabal} new-build all)'';

#sboo-cabal-update = ''time (${cabal} new-update && ${cabal} new-build all)'';

  #----------------------------------------------#

 sboo-emacs = ''${xdg-open} ${applications.emacs.desktop}'';

 # ^ NOTE « &disown » is implicit in « xdg-open _.desktop ».

 sboo-emacs-build = ''emacs  --directory=./  -batch  --funcall=batch-byte-compile'';

  #----------------------------------------------#

 sboo-date = ''date +%Y-%m-%d'';

 # ^ NOTE the date-format is year-first.

  #----------------------------------------------#

 sboo-zip-configs = ''tar -cz -v  -f "config_$(date +%Y-%m-%d).tar.gz"  -C /  "home/${env.HOME}/.config" "etc/xdg/xfce4" "etc/xdg/Thunar" "etc/xdg/menus" "etc/xdg/xdg-xubuntu" '';
 sboo-zip-themes  = ''tar -cz -v  -f "themes_$(date +%Y-%m-%d).tar.gz"  -C /  "home/${env.HOME}/.themes" "home/${env.HOME}/.icons" "usr/share/themes" "usr/share/icons" '';
 sboo-zip-libs    = ''tar -cz -v  -f "libs_$(date +%Y-%m-%d).tar.gz"    -C /  "usr/bin" "usr/local/bin" "usr/lib" "usr/local/lib" '';

# ^ « tar -C / »:
#
# • avoid absolute filepaths. 
# • ‹cd› to root directory, then create a relative archive.
# • extracting relative filepaths is always safe. after extraction, ‹mv› them under « / ».
#

  #----------------------------------------------#

  sboo-restart-ethernet = ''sudo ${dhclient} enxa44cc89c79ed '';

  #----------------------------------------------#

  sboo-refresh-font-cache =''sudo fc-cache -f -v '';

  #----------------------------------------------#
}
##################################################