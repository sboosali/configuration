##################################################
{ pkgs

, sboo
, env

# , xdg 
}:
##################################################
let

mkdir       = ''${pkgs.coreutils}/bin/mkdir'';

find        = ''${pkgs.findutils}/bin/find'';
xargs       = ''${pkgs.findutils}/bin/xargs'';

tar         = "tar"; #TODO# ''${pkgs.tar}/bin/tar'';

git         = ''${pkgs.git}/bin/git'';

xclip       = ''${pkgs.xclip}/bin/xclip'';
xdotool     = ''${pkgs.xdotool}/bin/xdotool'';
wmctrl      = ''${pkgs.wmctrl}/bin/wmctrl'';
xbrightness = ''${pkgs.xbrightness}/bin/xbrightness'';
xbindkeys   = ''${pkgs.xbindkeys}/bin/xbindkeys'';
#xmodmap    = ''${pkgs.xmodmap}/bin/xmodmap'';

xrandr               = ''${xrandr}/bin/xrandr'';
xrandr-invert-colors = ''${pkgs.xrandr-invert-colors}/bin/xrandr-invert-colors'';

xdg-open     = ''${pkgs.xdg_utils}/bin/xdg-open'';
# xdg-mime     = ''${pkgs.xdg_utils}/bin/xdg-mime'';
# xdg-settings = ''${pkgs.xdg_utils}/bin/xdg-settings'';

xprop       = ''${pkgs.xorg.xprop}/bin/xprop'';

redshift   = ''${pkgs.redshift}/bin/redshift'';

cabal      = ''${pkgs.cabal-install}/bin/cabal'';

##################################################

NIX_PROFILE = "~/.nix-profile";
NIXPKGS     = "${env.HOME}/nixpkgs";

#NixProfile = "${env.HOME}/.nix-profile";
#NixProfile = "${env.HOME}/.nix-profile";

in
##################################################
{

 #################################################

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

 "de" = "cd ~/.emacs.d";
 "dc" = "cd ~/configuration";
 "dh" = "cd ~/haskell";
 "dn" = "cd ~/notes";

 "dw" = "cd ~/Downloads";
 "dm" = "cd ~/Documents";
 "dr" = "cd ~/Dropbox";

 "dt" = "cd ~/temporary";
 "dk" = "cd ~/backup";

 "dx"  = ''cd ${NIXPKGS}'';
 "dxp" = ''cd ${NIX_PROFILE}'';

 "dxb" = ''cd ${NIX_PROFILE}/bin'';
 "dxe" = ''cd ${NIX_PROFILE}/etc'';
 "dxs" = ''cd ${NIX_PROFILE}/share'';
 "dxl" = ''cd ${NIX_PROFILE}/lib'';
 "dxi" = ''cd ${NIX_PROFILE}/include'';
#"dx" = ''cd ${NIX_PROFILE}/'';

 #################################################

 c = "cat";

 #-----------------------------------------------#

 #################################################

 o = "echo";

 #-----------------------------------------------#

 #################################################

 l = ''ls -alF'';

 #-----------------------------------------------#

 ll=''ls -alF'';
 la=''ls -A'';
 lc=''ls -CF'';

 # ^ « ls »

 #################################################

 r = "rm -f";

 # ^ « rm »

 #-----------------------------------------------#

 rr = "rm -fr";

 #################################################

 md="${mkdir} -p";

 # ^ « mkdir »

 #################################################

 sa   = ''. ~/.aliases'';
 sba  = ''. ~/.bash_aliases'';
 sbrc = ''. ~/.bashrc'';

 sbc-usr  = ''. /usr/share/bash-completion/bash_completion'';
 sbc-etc  = ''. /etc/bash_completion'';

 # ^ "s" prefix for "source".
 # 

 #################################################

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

 #################################################

 p = "grep -i -n -C 0";

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

  pr = "grep -i -n -C 0 --dereference-recursive";
  pv = "grep -i -n -C 0 --invert-match";
  pw = "grep -i -n -C 0 --word-regexp";
  pl = "grep -i -n -C 0 --line-regexp";

  # ^
  # -v, --invert-match        select non-matching lines
  # -w, --word-regexp         force PATTERN to match only whole words
  # -x, --line-regexp         force PATTERN to match only whole lines

 #-----------------------------------------------#

 pf = "grep -i -n -C 0 --fixed-strings";
 pe = "grep -i -n -C 0 --extended-regexp";
 pp = "grep -i -n -C 0 --perl-regexp";
 pg = "grep -i -n -C 0 --basic-regexp";

  # ^
  # -E, --extended-regexp     PATTERN is an extended regular expression (ERE)
  # -F, --fixed-strings       PATTERN is a set of newline-separated strings
  # -G, --basic-regexp        PATTERN is a basic regular expression (BRE)
  # -P, --perl-regexp         PATTERN is a Perl regular expression

 #################################################

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

 #################################################

 # = "${}";
 
 #-----------------------------------------------#

 #################################################
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

 #################################################

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

 #-----------------------------------------------#

 #################################################

 #################################################

 #################################################

 #################################################

 #################################################

 #################################################

 #################################################

 #################################################

 untargz = "${tar} -v -f -z --gzip";

 # ^ Uncompress and Extract a « .tar.gz »

 untarbz2 = "${tar} -v -f -z --bzip2";

 # ^ Uncompress and Extract a « .tar.bz2 »

 from-tarball = "${tar} -v -f -z";

 # ^ Uncompress and Extract (infer compression from file-extension).

 #################################################

 yt = ''${pkgs.youtube-dl}/bin/youtube-dl -f 22'';

 #TODO melpa2nix = ''${pkgs.emacs2nix}/bin/melpa2nix'';

 #################################################

 alert = ''notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')"'';

 # ^ « notify-send »:
 #
 # for long running commands. Usage: « sleep 10; alert "OPTIONAL MESSAGE" »

 git-status-subdirs = ''find . -mindepth 1 -maxdepth 1 -type d -exec sh -c '(echo {} && cd {} && git status -s && echo)' \;'';

 #################################################
}
##################################################