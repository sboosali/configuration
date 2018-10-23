##################################################
{ pkgs

, sboo

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
xdg         = ''${pkgs.xdg_utils}/bin/xdg-open'';
xbrightness = ''${pkgs.xbrightness}/bin/xbrightness'';
xbindkeys   = ''${pkgs.xbindkeys}/bin/xbindkeys'';
#xmodmap     = ''${pkgs.xmodmap}/bin/xmodmap'';

xprop       = ''${pkgs.xorg.xprop}/bin/xprop'';

cabal       = ''${pkgs.cabal-install}/bin/cabal'';

in
##################################################
{

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

 ff   = ''${find} . -type f'';
 fd   = ''${find} . -type d'';
 fx   = ''${find} . -type f -executable'';

 #-----------------------------------------------#

 "f." = ''${find} .'';
 f1   = ''${find} . -maxdepth 1'';
 f2   = ''${find} . -maxdepth 2'';
 f3   = ''${find} . -maxdepth 3'';

 #################################################

 g = "${git}";

 #-----------------------------------------------#

 "ga," = "${git} add .";
 "gau" = "${git} add -u";

 #-----------------------------------------------#

 "gc"  = "${git} commit";
 "gcm" = "${git} commit -m";
 "gc." = "${git} commit -m .";

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
 xb   = ''${xbindkeys}'';
 #-----------------------------------------------#
 #xm   = ''xmodmap''
 #-----------------------------------------------#
 #################################################

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

 yt = ''${pkgs.youtube-dl}/bin/youtube-dl -f 22''

 melpa2nix = ''${pkgs.emacs2nix}/bin/melpa2nix'';

 #################################################

 alert = ''notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')"'';

 # ^ « notify-send »:
 #
 # for long running commands. Usage: « sleep 10; alert "OPTIONAL MESSAGE" »

 git-status-subdirs = ''find . -mindepth 1 -maxdepth 1 -type d -exec sh -c '(echo {} && cd {} && git status -s && echo)' \;'';

 #################################################
}
##################################################