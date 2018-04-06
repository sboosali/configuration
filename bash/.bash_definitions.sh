#!/bin/bash

# set -u 
# which will cause any unset argument reference to immediately fail the script.

########################################
## NOTES
# this file is "pure", it only declares aliases and functions.
# like .bash_aliases plus .bash_functions

# TODO increase portability, just `sh`, not `bash`

## multiline strings

# echo -e <<EOF
# this is a multiline string
# that's echoed.
# EOF

# cat <<EOF > /dev/null
# this is a multiline string
# that's written to a file.
# EOF

# read -r -d '' A_MULTILINE _STRING <<EOF
# this is a multiline string
# that's assigned to a variable.
# EOF

# (Function-)Local Variables
#   
#   $ help local
#   local: local [option] name[=value] ...
#   Define local variables.
#   
#   Create a local variable called NAME, and give it VALUE.  OPTION can
#   be any option accepted by `declare'.
#   
#   Local variables can only be used within a function; they are visible
#   only to the function where they are defined and its children.
#   
#   Exit Status:
#   Returns success unless an invalid option is supplied, an error occurs,
#   or the shell is not executing a function.
# 

########################################
## DEFINITIONS 

function brush () {
  # synonym for "touch"
  mkdir -p "$(dirname "$1")"
  touch "$1"
}
alias t=brush

# short
alias d=cd
alias c=cat
alias n=nano
#alias r='rm -r'
alias l='ls -al'
alias f=find
alias g=git
alias o=echo
alias m=man
# alias e="echo" # emacs

# cd
# d == cd == 'cd ~'
alias d-="cd -"
alias d..="cd .."
alias d...="cd ../.."
alias d....="cd ../../.."
alias d.....="cd ../../../.."
alias d......="cd ../../../../.."
alias d.......="cd ../../../../../.."
alias de='cd ~/.emacs.d'
alias dew='cd ~/.emacs.d-windows'
alias dc='cd ~/configuration'
alias dh='cd ~/haskell'
alias dt='cd ~/temporary'
alias dw='cd ~/Downloads'
alias dm='cd ~/Documents'
alias dn='cd ~/.nixpkgs'
# alias d='cd '
# alias d='cd '

# cat
function copy-file() {
  FILE="${1:?}"
  cat "$FILE" | xclip -selection clipboard
  cat "$FILE"
}

# grep
alias p="grep -E -i -n --color=auto"
alias pf="grep -F"

# create parent directories by default
alias mkdir='mkdir -pv'
alias md='mkdir -pv'

# requires: colordiff package
if [ -x "$(command -v colordiff)" ]; then
  alias diff='colordiff'
else
  echo '[WARNING] colordiff is not installed, using diff.' >&2
fi


# ls 
alias ll='ls -alF'
alias la='ls -A'
alias lc='ls -CF'

# copy/paste
alias xc='xclip -selection clipboard'
alias xp='xclip -selection clipboard -o'
alias copy='xclip -selection clipboard'

# xbrightness
alias xb='xbrightness'
alias xbr='xbrightness 65535'

# workflow
alias open='xdg-open'
alias xd='xdotool'
alias xw='wmctrl'
alias xo='xdg-open'
function open () {
  xdg-open &disown
}

# keybindings
alias xm='xmodmap'
alias xb='xbindkeys'

# e.g.
# grep '^\S*' 
# \S means match non-whitespace character.
# And anchor ^ is used to match at the beginning of the line.

# editing
function seteditor () {
   export EDITOR="$1"
}

# emacs
function e () { 
 emacsclient "$@" & 
}
alias ee="emacsclient"
alias eb='$EDITOR ~/.bashrc && source ~/.bashrc' # single-quotes for dynamically-scoped EDITOR
alias ed="emacs --debug-init"
alias eq="emacs -q"
alias edq="emacs -q --debug-init"
alias ec="emacs -q ~/.emacs.d/init.el" # to debug

# nano
alias nb="nano ~/.bashrc && source ~/.bashrc"

# Reloading
# mnemonic: "s" for sourcing
alias sbr="source ~/.bashrc"
alias sbd="source ~/.bash_definitions.sh" # should be idempotent
alias sba="source ~/.aliases"             # should be idempotent
alias sbs="source ~/.bash_settings.sh"
alias sbp="source ~/.profile"
function se () {
    (cd ~/.emacs.d && nix-build emacs.nix && ./result/bin/emacs --debug-init)
}

# rm
alias rm="rm -f"
alias rr="rm -rf"
#
# alias rmr=rr #TODO
# alias rmt=rt #TODO
#
#alias rta='rm -f *~ .*~ \#*\# .\#* matlab_crash_dump.* java.log.* *.pyc *.class __pycache__/*.pyc *.agdai *.hi *.hout *.o'
#alias rtr='rm -fr *~ .*~ \#*\# .\#* matlab_crash_dump.* java.log.* *.pyc *.class __pycache__/*.pyc *.agdai *.hi *.hout *.o'
#

# remove temporary files recursively
# emacs temp files: '*~ .*~ \#*\# .\#*'
function rt() {
 find .  -type f  \( -name '*~'  -o  -name '\#*\#'  -o  -name '.\#*' \)  -print  -delete

 # print whatever's deleted

 # If your OS isn't Linux, replace -delete by -exec rm {} +.

 # find . -name \*~ | xargs rm
}

# `rtr` dry-run
function rtr-dry() {
 find .  -type f  \( -name '*~' -o -name '\#*\#' -o -name '.\#*' \)  -print
}

# chmod
alias c7="chmod 700"

# help aliases
alias lnh="echo 'ln -sf /path/to/file /path/to/symlink'"

# misc
alias disksize="df -h /"
function dirsize () {
 du -hcs "$@"
 # du --total --dereference --human-readable "$@"
 # #  dereference all symbolic links
}
function filesize () {
 # shellcheck disable=
 du -h "${@:?}" | cut -f1
# https://unix.stackexchange.com/questions/208184/issue-an-error-when-using-empty-shell-variables
# e.g.
# ~$ : "${UNSET_VAR?Unset variable}"
# bash: UNSET_VAR: Unset variable
}

# alias cpr="rsync -arRv" # e.g. cpr stuff backup # ./backup/stuff doesn't exist yet and is created
# alias cprd="rsync -arRv --dry-run" # --exclude ".stack-work" --exclude "dist-newstyle"

alias lnr='readlink -f'
alias lns='ln -sf' # /path/to/file /path/to/symlink
# alias pwn="sudo chown -R sboo:users"
alias yt='youtube-dl -f 22' # needs youtube-dl
# alias unzip="7z x" # needs 7z

# Natural Language Commands
alias list="ls -1aFG"
alias remove="rm -f"
alias show="cat"
alias get="git"
alias grab="grep"
alias processes=ps

alias synchronize="rsync -vihh -x -C -aR"
    # e.g. 
    #
    #      $ cd ~
    #      $ synchronize haskell/spiros/sources ~/backup
    #
    # wildcards work:
    #
    #      $ synchronize haskell/commands/commands-spiros/config* ~/backup/
    #      # includes: config/ config-linux/ config-osx/ config-windows/

alias dry-synchronize="synchronize --dry-run"
    # 

alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'

alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'

## pass options to free ##
alias meminfo='free -m -l -t'
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
## Get server cpu info ##
alias cpuinfo='lscpu' 
## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

# e.g.

# $ cpuinfo
# Architecture:          x86_64
# CPU op-mode(s):        32-bit, 64-bit
# Byte Order:            Little Endian
# CPU(s):                8
# On-line CPU(s) list:   0-7
# Thread(s) per core:    2
# Core(s) per socket:    4
# Socket(s):             1
# NUMA node(s):          1
# Vendor ID:             GenuineIntel
# CPU family:            6
# Model:                 158
# Model name:            Intel(R) Core(TM) i7-7820HQ CPU @ 2.90GHz
# Stepping:              9
# CPU MHz:               799.992
# CPU max MHz:           3900.0000
# CPU min MHz:           800.0000
# BogoMIPS:              5807.98
# Virtualization:        VT-x
# L1d cache:             32K
# L1i cache:             32K
# L2 cache:              256K
# L3 cache:              8192K
# NUMA node0 CPU(s):     0-7
# Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch epb invpcid_single intel_pt kaiser tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp

# $ meminfo              total        used        free      shared  buff/cache   available
# Mem:          32027       16709         541        1205       14775       13546
# Low:          32027       31485         541
# High:             0           0           0
# Swap:             0           0           0
# Total:        32027       16709         541

# $ gpumeminfo
# [     5.860] (--) NVIDIA(0): Memory: 4194304 kBytes
# [     6.657] (II) NVIDIA: Using 12288.00 MB of virtual memory for indirect memory
# [     6.678] (==) NVIDIA(0): Disabling shared memory pixmaps

# ps
# TODO alias psa="ps -o \"command, pid, %mem, %cpu, user, start, \" "

# python
#alias pi="ipython"
alias p3="python3"
alias p2="python2.7"

# git
alias g="git"
alias gl="git status" # mnemonic: git "list"
alias gd="git dif"
alias ga="git amend"
alias gorc="git status --porcelain | cut -d ' ' -f 3 | tr '\\n' ' '"

# # cleaning TODO
# alias clean-haskell="remove \"$1\".{dyn_hi,dyn_o,hi,o}"
# alias clean-emacs='remove "${1:?}".~ .\#"${1:?}"'

########################################
## NIX

alias emacs-nix='./result/bin/emacs -q --load "./init.el"' # relative filepaths

alias nf='nix-env -f"' # e.g. nf "<nixpkgs>"
alias ne='nix-env -f "<nixpkgs>"'
alias nea='nix-env -A -f "<nixpkgs>"'
alias ni="nix-env -i"
alias nu="nix-env --uninstall"
alias nua="nix-env -u '*'"

alias nix-build="nix-build --show-trace"
alias nb="nix-build"
alias nbe="nix-build ~/.nixpkgs/environment.nix" #TODO home.nix

alias nix-shell="nix-shell --show-trace"
alias nl="nix-shell"
alias nlp="nix-shell --pure"
alias nlr="nix-shell --run"
alias nlrp="nix-shell --pure --run"
alias nlx="nix-shell --run return"
alias nlxp="nix-shell --pure --run exit"

alias nix-eval="nix-instantiate --eval"
alias nx="nix-instantiate --eval"
alias nxv="nix-instantiate --eval"
alias nxp="nix-instantiate --parse"
alias nxe="nix-instantiate --eval"
alias nxs="nix-instantiate --eval --strict" 
  # recursively evaluate list elements and attributes
  # NOTE may loop
alias nxx="nix-instantiate --expr" # nxx 'import ./"$1" {}'
           # Interpret the command line arguments as a list of Nix expressions to be parsed and evaluated, rather than as a list of
           # file names of Nix expressions. 
# alias nx1="nix-instantiate --eval" # eval unary with defaults
# alias nx2="nix-instantiate --eval" # eval binary with defaults
#alias nx1="nix-instantiate --eval" # eval unary with defaults

# function nx1() { 
#  NIX_FILE="${1-?}"
#  #NIX_FILES="${@}"
#  # nix-instantiate --strict --expr "(import ./${NIX_FILE} {})"
#  # nix-instantiate --strict --eval "${NIX_FILES}"
#  nix-instantiate --strict --expr "let f = import ./${NIX_FILE}; x = {}; y = f x; in builtins.trace y y"
# }

function nx1() {
 nix-instantiate --strict --expr "let f = import ./${1?}; x = {}; y = f x; in builtins.trace y y"
}

       # --eval
       #     Just parse and evaluate the input files, and print the resulting values on standard output. No instantiation of store
       #     derivations takes place.
       #
       # --expr / -E
       #     Interpret the command line arguments as a list of Nix expressions to be parsed and evaluated, rather than as a list of
       #     file names of Nix expressions. (nix-instantiate, nix-build and nix-shell only.)

alias ns="nix-store"
alias nsr='nix-store --query --references'

alias ncu='nix-channel --update && nix-env --upgrade'
# "nix-channel --update"
# alias ncux="nix-channel --update nixpkgs"

alias npg="nix-prefetch-git --quiet"
alias npu="nix-prefetch-url"

#alias n="nix-"
#alias n="nix-"

function nq() {
 nix-env --system-filter "x86_64-linux" -qa \* -P | grep -F -i "$1";
}

function nql() {
 nix-env -q \* -P | grep -F -i "$1";
 # local
} 

#TODO `arch`-`uname`
#e.g. --system-filter "x86_64-linux"
function nia() {
 nix-env -f "<nixpkgs>" --system-filter "x86_64-linux" -i -A "$@"
}

# 'h': (default) haskell package
function nih() {
 nix-env -f "<nixpkgs>" -i -A "haskellPackages.$*"
}

# 'hc': haskell package, given a haskell compiler
function nihc() {
 nix-env -f "<nixpkgs>" -i -A "haskell.packages.${1-?}.${2-?}"
}

function nie() {
 nix-env -f "<nixpkgs>" -i -A "emacsPackagesNg.melpaPackages.$*"
}

function nqh() {
 nix-env -f "<nixpkgs>" -qaP -A haskellPackages | grep -i "$@"
}

function nqe() {
 nix-env -f "<nixpkgs>" -qaP -A emacsPackagesNg.melpaPackages | grep -i "$@"
}

alias nix-make-shell='cabal2nix *.cabal --sha256=0 --shell > shell.nix'
alias nix-make-default='cabal2nix *.cabal > default.nix'

function nix-install-haskell() {
 nix-env -f "<nixpkgs>" -i -A "haskellPackages.${1:?}"
}


function nix-prefetch-all-cabal-hashes() {

 URL=https://github.com/commercialhaskell/all-cabal-hashes/archive/current-hackage.tar.gz

 NOW=$(date '+%Y-%m-%d-%Hh%M')
 NAME="_all-cabal-hashes_$NOW"

 echo
 echo '[URL]'
 echo $URL
 echo
 echo '[NAME]'
 echo $NAME
 echo
 
 nix-prefetch-url --name $NAME --unpack --print-path $URL

}


# OLD
#  echo 'c = (import /etc/nixos/configuration.nix) { inherit (p) pkgs config lib; }'
function nr () {

 read -r -d '' NIX_REPL_EXAMPLES <<EOF

nixpkgs = import <nixpkgs> {}
b  = builtins
p  = nixpkgs
c  = p.config
l  = p.lib
ps = p.pkgs
hs = ps.haskellPackages
h  = p.haskell.lib
:a builtins
:a nixpkgs
:a nixpkgs.lib
spiros = hs.spiros

EOF

  echo
  echo -e "$NIX_REPL_EXAMPLES"
  echo
  nix-repl
}

function nix-where () {
  # obligatorily unary function
  #   bash: 1: parameter null or not set
  nix-instantiate "<nixpkgs>" -A "${1:?}" 2>/dev/null
}

# TODO
# function nsi () {
#   LOCATION=nix-instantiate "<nixpkgs>" -A "${1:?}"
#   nix-store --query --references "$LOCATION"
# }

function nsi () {
  LOCATION="$(nix-where "${1:?}")"
  nix-store --query --references "$LOCATION"
}

########################################
## HASKELL

## haskell

# alias hn="stack setup" # "n"ew
# alias hb="stack build"
# function he() { 
#  stack exec -- "$@" 
# }

alias hc="cabal new-configure"
alias hb="cabal new-build"
alias hr="cabal new-run" 

# e.g.
# 
# $ h 
# # cabal new-build all
# 
# $ h test
# # cabal new-test all
# 
# $ h test backend
# # cabal new-test backend
#
function h() {
 cabal "new-${1:-build}" "${2:-all}"
}

# alias hcc="cabal configure"
# alias hcb="cabal build"

# # Running projects, ghc
# function h() {
#     PACKAGE="$(basename "$PWD")"
#     # stack build --ghc-options -fno-code
#     # if [ "$?" -ne 0 ]; then
#     # 	return 1;
#     # fi
#     if [ -f build.sh ]; then
#       echo '(./build.sh)'
#       # shellcheck disable=SC1091
#       source build.sh
#     else
#       stack build && _printDiv && stack exec -- example-"$PACKAGE" "$@"
#     fi
# # Running a script the first way runs it as a child process. Sourcing (the second way), on the other way, runs the script as if you entered all its commands into the current shell - if the script sets a variable, it will remain set, if the script exits, your session will exit. See help . for documentation
# }

function ht() {
    PACKAGE="$(basename "$PWD")"
    stack build && _printDiv && stack test
}

# Running projects, ghcjs
function j() {
    PACKAGE="$(basename "$PWD")"
    if [ -f build.sh ]; then
      echo '(./build.sh)'
      # shellcheck disable=SC1091
      source build.sh
    else
      # shellcheck disable=SC2059
      stack build && _printDiv && stack exec -- example-"$PACKAGE" "$@"
    fi
# Running a script the first way runs it as a child process. Sourcing (the second way), on the other way, runs the script as if you entered all its commands into the current shell - if the script sets a variable, it will remain set, if the script exits, your session will exit. See help . for documentation
}

function heg() {
    PACKAGE="$(basename "$PWD")"
    #.stack-work/install/x86_64-linux-*/lts-*/*/bin/example-$PACKAGE
    stack exec example-"$PACKAGE"
}

function hdot () {
 PACKAGE="$(basename "$PWD")"
 DIRECTORY=images
 # prunet boot packages  and wired-in
 # http://stackoverflow.com/a/10056017/1337806
 mkdir -p "$DIRECTORY"
 stack dot --external --prune base,base-orphans,ghc-prim,integer-gmp,integer-simple,hsc2hs,haddock,array,binary,bytestring,Cabal,ghc-compact,containers,deepseq,directory,filepath,haskeline,hoopl,hpc,pretty,process,terminfo,time,transformers,xhtml,parallel,stm,random,primitive,vector,dph,template-haskell,transformers-compat,hashable > "$DIRECTORY"/"$PACKAGE".dot
 dot -Tpng -o "$DIRECTORY"/"$PACKAGE".png "$DIRECTORY"/"$PACKAGE".dot 
 rm "$DIRECTORY"/"$PACKAGE".dot 
 "$BROWSER" file://"$(path "$DIRECTORY"/"$PACKAGE".png)" &disown
}

# scaffolding
# "h"askell "s"cript
function hs () { 

    _NAME="$1"
    _MESSAGE='hs SCRIPTNAME'
    if [ "$#" -ne 1 ]; then
        echo -e "$_MESSAGE"
	return 1
    fi

    _TEMPLATE_NAME=script.hsfiles
    _LOCAL_TEMPLATE=~/.stack/templates/"$_TEMPLATE_NAME"
    _REMOTE_TEMPLATE='https://raw.githubusercontent.com/sboosali/config/master/stack/templates/'"$_TEMPLATE_NAME"
    if [ -f "$_LOCAL_TEMPLATE" ]; then
	_TEMPLATE="$_LOCAL_TEMPLATE"
    else
	_TEMPLATE="$_REMOTE_TEMPLATE"
    fi

    _FILE="$_NAME".exe.hs

    stack new "$_NAME" "$_TEMPLATE"
    cd "$_NAME" || return
    chmod u+x "$_FILE"
    ./"$_FILE"
    "$EDITOR" "$_FILE" &disown

}

function hd () {
 stack haddock --open --keep-going 
}

# # New project scaffolding
# function hnew () {
#     PACKAGE="$1"
#     MODULE="$2"
#     _FILEPATH="$3"

#     MESSAGE='hnew PACKAGE MODULE FILEPATH''\n''e.g. hnew workflow-derived Workflow.Derived Workflow/Derived'

#     if [ "$#" -ne 3 ]; then
#         echo -e "$MESSAGE"
# 	return 1
#     fi

#     LOCAL_TEMPLATE=~/.stack/templates/spirosboosalis.hsfiles
#     REMOTE_TEMPLATE='https://raw.githubusercontent.com/sboosali/config/master/stack/templates/spirosboosalis.hsfiles'
#     if [ -f "$LOCAL_TEMPLATE" ]; then
# 	TEMPLATE="$LOCAL_TEMPLATE"
#     else
# 	TEMPLATE="$REMOTE_TEMPLATE"
#     fi
    
#     stack new "$PACKAGE" "$TEMPLATE" -pmodule:"$MODULE" -pfilepath:"$_FILEPATH"

#     if ! cd "$PACKAGE"; then
#         echo -e "$MESSAGE"
# 	return 1
#     fi

#     echo "$PACKAGE | copy"
#     "$BROWSER" http://github.com/new # create repository, manually

#     stack build
#     stack exec -- example-"$PACKAGE"

#     git init
#     git add .
#     git commit -m"1st"
#     git remote add origin git@github.com:sboosali/"$PACKAGE".git # https://github.com/sboosali/$PACKAGE.git
#     git push -u origin master

#     # open sources/$MODULE/Example.hs
# }



function new-haskell-project-simple () (
    set -e

    PACKAGE="${1}"
    MODULE="${2}"
    _FILEPATH="${3}"
    IDENTIFIER="${4}"

    # PACKAGE="${1:?}"
    # MODULE="${2:?}"
    # _FILEPATH="${3:?}"
    # IDENTIFIER="${4:?}"

    MESSAGE='new-haskell-project-simple PACKAGE MODULE FILEPATH IDENTIFIER ''\n''e.g. new-haskell-project validation-warning Validation.Warning Validation/Warning validation_warning'

    if [ "$#" -ne 4 ]; then
        echo -e "$MESSAGE"
	return 1
        # NOTE `return` v `exit`?
        # `return`, in the subshell-defined-function, still seems to work.
    fi

    TEMPLATE_NAME=spirosboosalis-simple
    LOCAL_TEMPLATE=~/.stack/templates/"$TEMPLATE_NAME".hsfiles
    REMOTE_TEMPLATE=https://raw.githubusercontent.com/sboosali/config/master/stack/templates/"$TEMPLATE_NAME".hsfiles
    if [ -f "$LOCAL_TEMPLATE" ]; then
	TEMPLATE="$LOCAL_TEMPLATE"
    else
	TEMPLATE="$REMOTE_TEMPLATE"
    fi

    echo
    echo "[TEMPLATE]"
    echo "$TEMPLATE"
    echo

    stack new "$PACKAGE" "$TEMPLATE" -p module:"$MODULE" -p filepath:"$_FILEPATH" -p identifier:"$IDENTIFIER" || true # ignore failure
    # -p synopsis:"$SYNOPSIS"

    if ! cd "$PACKAGE"; then
        echo -e "$MESSAGE"
	return 1
    fi

    mkdir -p ignore/
    mkdir -p release/
    # mkdir -p /

    NIX_DEFAULT_FILE="$PACKAGE.nix"
    cabal2nix . > "$NIX_DEFAULT_FILE"

    NIX_SHELL_FILE="shell.$PACKAGE.nix"
    cabal2nix . --shell > "$NIX_SHELL_FILE" 

    # SC2035
    chmod 700 ./*.sh

    echo
    echo "========================================"
    echo "[Building Everything...]"
    echo "========================================"
    echo

    # try to open a tab in the default browser to create a GitHub repository,
    # during the build (which should take a minute)
    GITHUB_URL=https://github.com/new
    xdg-open "$GITHUB_URL" 2>/dev/null || open "$GITHUB_URL" 2>/dev/null || true # ignore failure

    nix-shell "$NIX_SHELL_FILE" --arg doTest true --run 'cabal new-configure --enable-tests --enable-benchmarks'

    ./build.sh   || true
    ./test.sh    || true
    ./haddock.sh || true

    echo
    echo "========================================"
    echo "[Initializing Repository...]"
    echo "========================================"
    echo
    git init
    git add .
    git commit -m '1st'
    git remote add origin "git@github.com:sboosali/$PACKAGE".git
    git push -u origin master
)


# New project scaffolding
# 
# requires:
# nix, cabal2nix, sed (/stdenv), stack, cabal-install, hscolour,
#
# NOTES
# function definition is subshell ("(" not "{")
# 
# '''You may directly use a subshell as your function definition and set it to exit immediately with set -e. This would limit the scope of set -e to the function subshell only and would later avoid switching between set +e and set -e.
# In addition, you can use a variable assignment in the if test and then echo the result in an additional else statement.'''
# https://stackoverflow.com/questions/4072984/set-e-in-a-function
# 
function new-haskell-project () (
    set -e

    PACKAGE="${1}"
    MODULE="${2}"
    _FILEPATH="${3}"
    IDENTIFIER="${4}"

    # PACKAGE="${1:?}"
    # MODULE="${2:?}"
    # _FILEPATH="${3:?}"
    # IDENTIFIER="${4:?}"

    MESSAGE='new-haskell-project PACKAGE MODULE FILEPATH IDENTIFIER ''\n''e.g. new-haskell-project validation-warning Validation.Warning Validation/Warning validation_warning'

    if [ "$#" -ne 4 ]; then
        echo -e "$MESSAGE"
	return 1
        # NOTE `return` v `exit`?
        # `return`, in the subshell-defined-function, still seems to work.
    fi

    LOCAL_TEMPLATE=~/.stack/templates/spirosboosalis.hsfiles
    REMOTE_TEMPLATE='https://raw.githubusercontent.com/sboosali/config/master/stack/templates/spirosboosalis.hsfiles'
    if [ -f "$LOCAL_TEMPLATE" ]; then
	TEMPLATE="$LOCAL_TEMPLATE"
    else
	TEMPLATE="$REMOTE_TEMPLATE"
    fi

    echo
    echo "[TEMPLATE]"
    echo "$TEMPLATE"
    echo

    stack new "$PACKAGE" "$TEMPLATE" -p module:"$MODULE" -p filepath:"$_FILEPATH" -p identifier:"$IDENTIFIER" || true # ignore failure
    # -p synopsis:"$SYNOPSIS"

    if ! cd "$PACKAGE"; then
        echo -e "$MESSAGE"
	return 1
    fi

    # patch documentation
    # e.g. "Cards.Common-Example.html" -> "Cards-Common-Example.html"
    STRING_FROM="$MODULE"-Example.html
    STRING_INTO="$(echo "$MODULE"-Example | sed 's/\./-/g')".html
    sed -i  s/"$STRING_FROM"/"$STRING_INTO"/g  sources/"$_FILEPATH"/Example.hs
    sed -i  s/"$STRING_FROM"/"$STRING_INTO"/g  README.md

    # patch cabal file
    # e.g. "Paths_reflex-vinyl" -> "Paths_reflex_vinyl"
    STRING_FROM_2="Paths_$PACKAGE"
    STRING_INTO_2="$(echo "$STRING_FROM_2" | sed 's/-/_/g')"
    sed -i  s/"$STRING_FROM_2"/"$STRING_INTO_2"/g "$PACKAGE.cabal"

    NIX_DEFAULT_FILE="nix/$PACKAGE.nix"
    cabal2nix .         > "$NIX_DEFAULT_FILE"

    NIX_SHELL_FILE="nix/shell.nix"
    cabal2nix . --shell > "$NIX_SHELL_FILE" 

    # SC2035
    chmod 700 ./*.sh

    echo
    echo "========================================"
    echo "[Building Everything...]"
    echo "========================================"
    echo

    # try to open a tab in the default browser to create a GitHub repository,
    # during the build (which should take a minute)
    GITHUB_URL=https://github.com/new
    xdg-open "$GITHUB_URL" 2>/dev/null || open "$GITHUB_URL" 2>/dev/null || true # ignore failure

    nix-shell "$NIX_SHELL_FILE" --arg doBenchmark true --arg doTest true --run 'cabal configure --enable-tests --enable-benchmarks'

    # nix-shell "$SHELL_FILE" --arg doBenchmark true 
    cabal build
    cabal run "example-$PACKAGE"
    cabal test || true # ignore failure
    cabal bench || true # ignore failure
    cabal haddock --haddock-option="--hyperlinked-source" || true # ignore failure

    # (nix-shell && cabal build && cabal run example-$PACKAGE)

    echo
    echo "========================================"
    echo "[Initializing Repository...]"
    echo "========================================"
    echo
    git init
    git add .
    git commit -m '1st'
    git remote add origin "git@github.com:sboosali/$PACKAGE".git
    git push -u origin master
)

function prefetch-github () {

URL="${1:?}"

NAME=$(basename "$URL")

FILE="$NAME.json"

nix-prefetch-git "$URL" > "$FILE"

cat "$FILE"

}

# alias hnew=new-haskell-project

# To generate a Nix build expression for it, change into the project’s top-level directory and run the command:
# $ cabal2nix . >foo.nix
# Then write the following snippet into a file called default.nix:
# { nixpkgs ? import <nixpkgs> {}, compiler ? "ghc7102" }:
# nixpkgs.pkgs.haskell.packages.${compiler}.callPackage ./foo.nix { }
# Finally, store the following code in a file called shell.nix:
# { nixpkgs ? import <nixpkgs> {}, compiler ? "ghc7102" }:
# (import ./default.nix { inherit nixpkgs compiler; }).env

function c2n() { 
 echo 'cabal2nix $@ . > default.nix'
 cabal2nix . "$@" > default.nix
 cat default.nix
}

function c2l() { 
 echo 'cabal2nix --shell $@ . > shell.nix'
 cabal2nix --shell . "$@" > shell.nix
 cat shell.nix
 nix-shell --run ''
}


# function h2n() {
 
#  cabal2nix . > package.nix
#  # package.nix gets overwritten
#  # default.nix and shell.nix don't get overwritten, if present

#  if [[ ! -f default.nix ]]; then
#  cat <<EOF > default.nix
# { nixpkgs ? import <nixpkgs> {}, compiler ? "ghc822" }:
# nixpkgs.pkgs.haskell.packages.\${compiler}.callPackage ./package.nix { }
# EOF
#  fi

#  if [[ ! -f shell.nix ]]; then  # `-f` caveat: http://stackoverflow.com/questions/638975/how-do-i-tell-if-a-regular-file-does-not-exist-in-bash
#  cat <<EOF > shell.nix
# { nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

# let

#   inherit (nixpkgs) pkgs;

#   f = import ./default.nix;
#   ps = {
#     # spiros = ~/spiros; # TODO absolute
#   };

#   haskellPackages = if compiler == "default"
#                        then pkgs.haskellPackages
#                        else pkgs.haskell.packages.\${compiler};

#   drv = haskellPackages.callPackage f ps;

# in

#   if pkgs.lib.inNixShell then drv.env else drv
# EOF
#  fi
# }


# { ps ? (import <nixpkgs> {}).pkgs, mkDerivation
# , array, base, containers, deepseq, doctest, ghc-prim
# , spiros, stdenv, template-haskell, vinyl
# }:
# mkDerivation {
#   pname = "enumerate";
#   version = "0.2.1";
#   src = ./.;
#   isLibrary = true;
#   isExecutable = true;
#   libraryHaskellDepends = [
#     array base containers deepseq ghc-prim spiros template-haskell
#     vinyl
#   ];
#   executableHaskellDepends = [ base ]; # why no enumerate i.e. self?
#   testHaskellDepends = [ base doctest ];
#   homepage = "https://github.com/sboosali/enumerate";
#   description = "enumerate all the values in a finite type (automatically)";
#   license = stdenv.lib.licenses.mit;
#   # shellHook = '' '';
#   # buildTools = (with ps; [cabal-install haskellPackages.stack]);  
#   enableSplitObjs = false;
# }

# 
# http://alpmestan.com/posts/2017-09-06-quick-haskell-hacking-with-nix.html
# 
# e.g.
# $ nix-haskell-environment lens aeson wreq
# ==>
# $ nix-shell -p "haskell.packages.ghc822.ghcWithPackages (haskellPackages: with haskellPackages; [lens aeson wreq])"
#
# e.g.
# $ nix-haskell-environment zip-archive zlib -- zlib
# ==>
# $ nix-shell -p "haskell.packages.ghc822.ghcWithPackages (haskellPackages: with haskellPackages; [zip-archive zlib])"
#
# ([zlib xorg.xprop] ++ [haskell.packages.ghc822.ghcWithPackages (ps: with ps; [lens aeson wreq])])
#
function nix-haskell-system-environment () {
  HASKELL_COMPILER=ghc822 # e.g. "ghc822"
  HASKELL_PACKAGES="$*" # e.g. "lens aeson wreq"
#  SYSTEM_PACKAGES=  # e.g. "zlib xorg.xprop"
  
#  NIX_EXPRESSION="'([ ${SYSTEM_PACKAGES} ] ++ [ haskell.packages.${HASKELL_COMPILER}.ghcWithPackages (haskellPackages: with haskellPackages; [ ${HASKELL_PACKAGES} ])])'"

  NIX_EXPRESSION="haskell.packages.${HASKELL_COMPILER}.ghcWithPackages (haskellPackages: with haskellPackages; [ ${HASKELL_PACKAGES} ])'"

  nix-shell -p --show-trace -v "$NIX_EXPRESSION"
}

# 
# 
# 
# 
# 
# 
# 
# $ nix-instantiate --eval -E 'let nixpkgs = import <nixpkgs> {}; in with nixpkgs; with lib; attrNames haskell.packages'
# [ "ghc7103" "ghc7103Binary" "ghc802" "ghc821Binary" "ghc822" "ghcCross" "ghcHEAD" "ghcHaLVM240" "ghcjs" "ghcjsHEAD" "integer-simple" "stackage" ]
# 
function nix-haskell-environment () {
  if [[ $# -lt 2 ]];
  then
    echo '$ nix-haskell-environment COMPILER PACKAGE [PACKAGE...]'
    echo
    echo 'DESCRIPTION'
    echo
    echo '   a ghc version, and one-or-more haskell packages'
    echo
    echo 'EXAMPLE'
    echo
    echo '   nix-haskell-environment ghc822 lens aeson wreq'
    echo
    echo 'ARGUMENTS'
    echo
    echo '   COMPILER is one of:'
    echo '       '
    POSSIBLE_COMPILERS=$(nix-instantiate --eval --expr 'let nixpkgs = import <nixpkgs> {}; in with nixpkgs; with lib; let compilers = attrNames haskell.packages; in concatStringsSep "\n" ([""] ++ compilers ++ [""])')
    echo -e "${POSSIBLE_COMPILERS}"
    echo 
    echo '   PACKAGE'
    echo '       Almost always, Nixpkgs names (which must be valid Nix identifiers) and Hackage names coincide'
    echo
    echo '       (run the following command with any COMPILER from above, for example:)'
    echo
    # echo POSSIBLE_PACKAGES=nix-instantiate --eval --expr 'let nixpkgs = import <nixpkgs> {}; in with nixpkgs; with lib; let packages = attrNames haskell.packages.ghc822; in concatStringsSep "\n" ([""] ++ packages ++ [""])'
    # echo -e "${POSSIBLE_PACKAGES}"

    # set variable to heredoc
    read -r -d '' EXAMPLE_NIX_EXPRESSION <<EOF
let nixpkgs = import <nixpkgs> {}; in 
with nixpkgs; 
with lib; 
let packages = attrNames haskell.packages.ghc822; in 
concatStringsSep "\\n" ([""] ++ packages ++ [""])
EOF
    EXAMPLE_NIX_COMMAND="nix-instantiate --eval --expr '${EXAMPLE_NIX_EXPRESSION}'"
    echo -e "${EXAMPLE_NIX_COMMAND}"
    echo
    return 1;
    # e.g. nix-repl> lib.attrNames nixpkgs.haskell.packages
    # [ "ghc7103" "ghc7103Binary" "ghc802" "ghc821Binary" "ghc822" "ghcCross" "ghcHEAD" "ghcHaLVM240" "ghcjs" "ghcjsHEAD" "integer-simple" "stackage" ]
    #
  else
    HASKELL_COMPILER="$1" # e.g. "ghc822"
    HASKELL_PACKAGES="${*:2}" # e.g. "lens aeson wreq"
  #  SYSTEM_PACKAGES=  # e.g. "zlib xorg.xprop"

  #  NIX_EXPRESSION="'([ ${SYSTEM_PACKAGES} ] ++ [ haskell.packages.${HASKELL_COMPILER}.ghcWithPackages (haskellPackages: with haskellPackages; [ ${HASKELL_PACKAGES} ])])'"
    NIX_EXPRESSION="haskell.packages.${HASKELL_COMPILER}.ghcWithPackages (haskellPackages: with haskellPackages; [ ${HASKELL_PACKAGES} ])"
  
    nix-shell -p --show-trace -v "$NIX_EXPRESSION"
fi
}
 
########################################
## MORE DEFINITIONS

function _printDiv () {
  printf '\n\n'
  printf "%s" '----------------------------------------'
  printf '\n\n'
}

# function dog {
#  SEP="--------------------------------------------------------"
#  while read file; do
#      if [ -f "$file" ]; then
#          echo -e "\n"$SEP
#          echo "$file"
#          echo -e $SEP"\n"
#          cat "$file"
#      fi
#  done
# }

function show-variable () {
 echo "$1" | tr ':' '\n'
}

# Pretty print the path
function show-path () {
 echo "$PATH" | tr ':' '\n'
}

# needs curl
function download {
    URL="$1"
    FILE=$(basename "$1")
    curl "$URL" > "$FILE"
}

function cobra () {
 python -c "
import sys
x = list(sys.stdin)[0].strip().split()
print($*)
"
}

function space () {
 stat -f%z "$@" | '(float(x[0])/1e9, "gigabytes")'
}

function raw-absolute-path {
 echo $(cd $(dirname "$1"); pwd)/$(basename "$1")

 # versus `readlink`, which
 # /reads links/, which will be by cosntruction identical
}

function true-absolute-path {
 readlink -f "$1"
}

function absolute-path {
 true-absolute-path "$@"
}
alias path=absolute-path

# https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
#
# filebasename=$(basename "$fullfile")
# extension="${filebasename##*.}"
# filename="${filebasename%.*}"
# filename="${fullfile##*/}"
#
function directory {
 FILEPATH="$1"
 DIRECTORY=$(dirname "$FILEPATH")
 echo "$DIRECTORY"
}
function filename {
 FILEPATH="$1"
 FILEBASE=$(basename "$FILEPATH")
 FILENAME="${FILEBASE%.*}"
 echo "$FILENAME"
}
function extension {
 FILEPATH="$1"
 EXTENSION="${FILEPATH##*.}"
 echo "$EXTENSION"
}

# https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
GPG_TTY=$(tty)
export GPG_TTY

# for github
#
# http://stackoverflow.com/questions/9607295/how-do-i-find-my-rsa-key-fingerprint
function ssh-fingerprint () {
 ssh-keygen -E md5 -lf "$1.pub"
} 

alias sshl='ssh-add -l'

function ssha () {
 _PRIVATE_KEY="$1"
 _MESSAGE='sshl PRIVATE_KEY'
 if [ "$#" -ne 1 ]; then
     echo "$_MESSAGE"
     return 1
 fi
 ssh-add ~/.ssh/"$_PRIVATE_KEY"
}

# # 
# function my-mysql() {
 
#  if [ $# -gt 1 ]
#  then echo "Usage: mysql [start stop \"\"]"
#       return 0
#  fi
 
#  case "$1" in
#  start) sudo /opt/local/bin/mysqld_safe5 &
#  ;;
#  stop)  /opt/local/bin/mysqladmin5 -u root -p shutdown
#  ;;
#  "")    echo todo
#  ;;
#  *)     echo "Usage: mysql [start stop \"\"]"
#  ;;
#  esac
# }
 
# # 
# function my-postgresql {
# }

# # converts video to audio, and opens it
# function blind {
#  NAME="${1%%.*}"
#  INPUT="$NAME.mp4"
#  OUTPUT="$NAME.m4a"
#  # echo $NAME
#  ffmpeg  -i "$INPUT"  -c copy "$OUTPUT"
#  open "$OUTPUT"
# }

# ssh-add github
# passwd same as github.com
#
# ssh-key with passphrase, with ssh-ident:
# ssh-ident is an utility that can manage ssh-agent on your behalf and load identities as necessary. It adds keys only once as they are needed, regardless of how many terminals, ssh or login sessions that require access to an ssh-agent.
# alias ssh='ssh-ident' # TODO

########################################
## GIT 

function blame {
 FILE="$1"
 LINE="$2"
 git show "$(git blame "$FILE" -L "$LINE","$LINE" | awk '{print $1}')"
}

function clone () {
 # use ssh
 _GITHUB_USER="$1"
 _GITHUB_REPOSITORY="$2"
 _MESSAGE='clone USER REPOSITORY'
 if [ "$#" -ne 2 ]; then
        echo "$_MESSAGE"
        return 1
 fi
 git clone git@github.com:"$_GITHUB_USER"/"$_GITHUB_REPOSITORY".git
 cd "$_GITHUB_REPOSITORY" || return

 git branch --set-upstream-to=origin/master master

 git remote -v
 git branch -a
}

alias gc="clone sboosali"

# submodule
function git-mod () {
 _GITHUB_REPOSITORY=$1
 _MESSAGE='git-mod REPOSITORY'
 if [ "$#" -ne 1 ]; then
        echo "$_MESSAGE"
 	return 1
 fi
 git submodule add git@github.com:sboosali/"$_GITHUB_REPOSITORY".git "$_GITHUB_REPOSITORY"
}

# e.g.
# git remote set-url origin $( make-github-ssh sboosali .emacs.d)
function make-github-ssh () {
 _GITHUB_USER="$1"
 _GITHUB_REPOSITORY="$2"
 git@github.com:"$_GITHUB_USER"/"$_GITHUB_REPOSITORY".git
}
 
# git subtree add -P <prefix> <repo> <rev>
function git-merge-repos () {
 _MESSAGE='git-merge-repos <prefix> <repo> <rev> (to be merged into the current one)'
 if [ "$#" -ne 3 ]; then
    echo "$_MESSAGE"
    return 1
 fi
 
 git subtree add -P "$@"
}

# # http://stackoverflow.com/questions/1425892/how-do-you-merge-two-git-repositories
# function git-merge-repos () {
# _FILEPATH="$1"
# _MESSAGE='git-merge-repos REPOSITORY_PATH (to be merged into the current one)'
# if [ "$#" -ne 1 ]; then
#         echo $_MESSAGE
# 	return 1
# fi
# _TEMPORARY=temporary-project
# git remote add $_TEMPORARY $_FILEPATH
# git fetch $_TEMPORARY
# git merge --allow-unrelated-histories $_TEMPORARY/master # or whichever branch you want to merge
# git remote remove $_TEMPORARY 
# }

# decompress a tarball, i.e. `.tar.gz`
# 
# https://askubuntu.com/questions/25347/what-command-do-i-need-to-unzip-extract-a-tar-gz-file
# 
# f: this must be the last flag of the command, and the tar file must be immediately after. It tells tar the name and path of the compressed file.
# z: tells tar to decompress the archive using gzip
# x: tar can collect files or extract them. x does the latter.
# v: makes tar talk a lot. Verbose output shows you all the files being extracted.
# 
function un-tarball() {
 tar -xvz -f "$@"
}

# unzip each zip file into its own folder
function unzip-each () {
 for i in *.zip; do 
   unzip "$i" -d "${i%%.zip}"
 done
}

function new-script () {

 FILENAME="$1"
 
 cat <<EOF > "$FILENAME"
#!/bin/bash
set -e
########################################

ARGUMENTS=

########################################

EOF
 
 chmod 700 "$FILENAME"
 emacsclient "$FILENAME"
}

########################################
## X

# eDP-1-1 is name of the laptop screen (the first field)
# "Why is it called eDP? bcause it is an embedded display port style adapter, and not a video graphics array style one."
# 0x42 is the Identifier from `xrandr --verbose`
# alias red="xrandr --output 0x42 --crtc 0 --gamma "
# xrandr -d :0 --output eDP-1-1 --gamma "1:1:1" # restore default
# xrandr -d :0 --output eDP-1-1 --gamma "1:1:1"

alias red="redshift -O 1000" # one-shot, 1000K
alias scarlet="redshift -O 1500" # one-shot
alias orange="redshift -O 2000" # one-shot
alias yellow="redshift -O 3000" # one-shot
alias white="redshift -x" # 
alias un-red="redshift -x" #

########################################
# ephemeral/specialized stuff

#TODO rm
alias melpa2nix=/nix/store/2g4pm399808pmz6zsd89m2iwahk439vi-emacs2nix-0.1.0.0/bin/melpa2nix 

########################################
# notes about shellcheck

# ^-- SC2142: Aliases can't use positional parameters. Use a function.
# ^-- SC2086: Double quote to prevent globbing and word splitting.
# ^-- SC2005: Useless echo? Instead of 'echo $(cmd)', just use 'cmd'.
# ^-- SC2006: Use $(..) instead of legacy `..`.

# ^-- SC2164: Use 'cd ... || exit' or 'cd ... || return' in case cd fails.
#
# cd can fail for a variety of reasons:
#   misspelled paths, missing directories, missing permissions, broken symlinks and more.
#
#  cd foo || exit as suggested to just abort immediately
#
#  if cd foo; then echo "Ok"; else echo "Fail"; fi for custom handling
#
#  For functions, you may want to use return:
#      func(){
#        cd foo || return
#        do_something
#      }
#
#

# print($@)
#       ^-- SC2145: Argument mixes string and array. Use * or separate argument.
#
# https://github.com/koalaman/shellcheck/wiki/SC2145
#
# E.g., with the parameters foo,bar,baz, "--flag=$@" is equivalent to the three arguments "--flag=foo" "bar" "baz".
# If the intention is to concatenate all the array elements into one argument, use $*. This concatenates based on IFS.

# if [ "$?" -ne 0 ]; then
#      ^-- SC2181: Check exit code directly with e.g. 'if mycmd;', not indirectly with $?.

#  if [ -z "$__git_ps1" ]; then
#           ^-- SC2154: __git_ps1 is referenced but not assigned.

