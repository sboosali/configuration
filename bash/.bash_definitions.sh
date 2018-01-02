#!/bin/bash

# this file is "pure", it only declares aliases and functions.
# like .bash_aliases plus .bash_functions

# TODO increase portability, just `sh`, not `bash`

########################################
## DEFINITIONS 

function brush () {
# synonym for "touch"
mkdir -p `dirname "$1"`
touch "$1"
}

# short
alias d='cd'
alias c='cat'
alias n=nano
alias r='rm -r'
alias l='ls -al'
alias t=brush
alias f='find'
alias g='git'
alias o="echo"
# alias e="echo" # emacs

# cd
alias dh='cd ~'
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
# alias d='cd '

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
alias xd='xdotool'
alias xw='wmctrl'
alias xo='xdg-open'
function open {
  xdg-open &disown
}

# keybindings
alias xm='xmodmap'
alias xb='xbindkeys'

# grep
alias r="grep -E --color=auto -i"

# editing
function seteditor {
   export EDITOR="$1"
}

# emacs
function e() { 
 emacsclient "$@" & 
}
alias ee="emacsclient"
alias eb="$EDITOR ~/.bashrc && source ~/.bashrc"
alias ed="emacs --debug-init"
alias eq="emacs -q"
alias edq="emacs -q --debug-init"
alias ec="emacs -q ~/.emacs.d/init.el" # to debug

# nano
alias nb="nano ~/.bashrc && source ~/.bashrc"

# Reloading
# mnemonic: "s" for sourcing
alias sb="source ~/.bashrc"
alias sbd="source ~/.bash_definitions.sh" # should be idempotent
alias sba="source ~/.aliases" # should be idempotent
alias sbs="source ~/.bash_settings.sh"
alias sbp="source ~/.profile"
function se () {
    (cd ~/.emacs.d && nix-build emacs.nix && ./result/bin/emacs --debug-init)
}

# rm
alias rm="rm -f"
alias rmr="rm -rf"
alias rmt="rm -f *~ .*~ \#*\# .\#* matlab_crash_dump.* java.log.* *.pyc *.class __pycache__/*.pyc *.agdai *.hi *.hout *.o"

# chmod
alias c7="chmod 700"

# help aliases
alias lnh="echo 'ln -sf /path/to/file /path/to/symlink'"

# misc
alias disksize="df -h /"
alias cpr="rsync -arRv" # e.g. cpr stuff backup # ./backup/stuff doesn't exist yet and is created
alias cprd="rsync -arRv --dry-run" # --exclude ".stack-work" --exclude "dist-newstyle"
alias lnr='readlink -f'
alias lns='ln -sf' # /path/to/file /path/to/symlink
# alias pwn="sudo chown -R sboo:users"
alias yt='youtube-dl -f 22' # needs youtube-dl
alias unzip="7z x" # needs 7z

# Natural Language Commands
alias list="ls -1aFG"
alias remove="rm -f"
alias show="cat"
alias get="git"
alias grab="grep"
alias processes=ps

# ps
# TODO alias psa="ps -o \"command, pid, %mem, %cpu, user, start, \" "

# python
alias p="python3"
alias pi="ipython"
alias p3="python3"
alias p2="python2.7"

# git
alias g="git"
alias gl="git status" # mnemonic: git "list"
alias gd="git dif"
alias ga="git amend"
alias gorc="git status --porcelain | cut -d ' ' -f 2 | tr '\n' ' '"

# cleaning TODO
alias clean-haskell="remove \"$1\".{dyn_hi,dyn_o,hi,o}"
alias clean-emacs="remove $1.{~} .#$1"

########################################
## NIX

alias emacs-nix='./result/bin/emacs -q --load "./init.el"' # relative filepaths

alias ne='nix-env -f "<nixpkgs>"'
alias nea='nix-env -A -f "<nixpkgs>"'
alias ni="nix-env -i"
alias nb="nix-build"
alias ns="nix-store"
alias nlp="nix-shell --pure"
alias nl="nix-shell"
alias nbe="nix-build ~/.nixpkgs/environment.nix"
alias nsr='nix-store --query --references'
alias nsi='nix-store --query --references $(nix-instantiate "<nixpkgs>" -A "$1")'
alias ncu="nix-channel --update"
alias ncux="nix-channel --update nixpkgs"
alias nua="nix-env -u '*'"
alias neu="nix-env --uninstall"
#alias n="nix-"
#alias n="nix-"

nq(){ nix-env -qa \* -P | fgrep -i "$1"; }
nql(){ nix-env -q \* -P | fgrep -i "$1"; } # local

function nia() {
 nix-env -f "<nixpkgs>" -i -A "$@"
}

function nih() {
 nix-env -f "<nixpkgs>" -i -A haskellPackages."$@"
}

function nie() {
 nix-env -f "<nixpkgs>" -i -A emacsPackagesNg.melpaPackages."$@"
}

function nqh() {
 nix-env -f "<nixpkgs>" -qaP -A haskellPackages | grep -i "$@"
}

function nqe() {
 nix-env -f "<nixpkgs>" -qaP -A emacsPackagesNg.melpaPackages | grep -i "$@"
}

alias nix-make-shell='cabal2nix *.cabal --sha256=0 --shell > shell.nix'
alias nix-make-default='cabal2nix *.cabal > default.nix'

function nr () {
  echo 'p = import <nixpkgs> {}'
  echo 'c = (import /etc/nixos/configuration.nix) { inherit (p) pkgs config lib; }'
  nix-repl
}

########################################
## HASKELL

## haskell

# alias hn="stack setup" # "n"ew
# alias hb="stack build"
# function he() { 
#  stack exec -- "$@" 
# }

alias hcc="cabal configure"
alias hcb="cabal build"

# Running projects, ghc
function h() {
    PACKAGE=$(basename $PWD)
    # stack build --ghc-options -fno-code
    # if [ "$?" -ne 0 ]; then
    # 	return 1;
    # fi
    if [ -f build.sh ]; then
    echo '(./build.sh)'
    source build.sh
    else
    stack build && printf $DIV && stack exec -- example-$PACKAGE "$@"
    fi
# Running a script the first way runs it as a child process. Sourcing (the second way), on the other way, runs the script as if you entered all its commands into the current shell - if the script sets a variable, it will remain set, if the script exits, your session will exit. See help . for documentation
}

function ht() {
    PACKAGE=$(basename $PWD)
    stack build && printf $DIV && stack test
}

# Running projects, ghcjs
function j() {
    PACKAGE=$(basename $PWD)
    if [ -f build.sh ]; then
    echo '(./build.sh)'
    source build.sh
    else
    stack build && printf $DIV && stack exec -- example-$PACKAGE "$@"
    fi
# Running a script the first way runs it as a child process. Sourcing (the second way), on the other way, runs the script as if you entered all its commands into the current shell - if the script sets a variable, it will remain set, if the script exits, your session will exit. See help . for documentation
}

function heg() {
    PACKAGE=$(basename $PWD)
    #.stack-work/install/x86_64-linux-*/lts-*/*/bin/example-$PACKAGE
    stack exec example-$PACKAGE
}

function hdot () {
PACKAGE=$(basename $PWD)
DIRECTORY=images
# prunet boot packages  and wired-in
# http://stackoverflow.com/a/10056017/1337806
mkdir -p $DIRECTORY
stack dot --external --prune base,base-orphans,ghc-prim,integer-gmp,integer-simple,hsc2hs,haddock,array,binary,bytestring,Cabal,ghc-compact,containers,deepseq,directory,filepath,haskeline,hoopl,hpc,pretty,process,terminfo,time,transformers,xhtml,parallel,stm,random,primitive,vector,dph,template-haskell,transformers-compat,hashable > $DIRECTORY/$PACKAGE.dot
dot -Tpng -o $DIRECTORY/$PACKAGE.png $DIRECTORY/$PACKAGE.dot 
rm $DIRECTORY/$PACKAGE.dot 
chromium file://$(path $DIRECTORY/$PACKAGE.png) &disown
}

# scaffolding
# "h"askell "s"cript
function hs () { 

    _NAME="$1"
    _MESSAGE='hs SCRIPTNAME'
    if [ "$#" -ne 1 ]; then
        echo -e $_MESSAGE
	return 1
    fi

    _TEMPLATE_NAME=script.hsfiles
    _LOCAL_TEMPLATE=~/.stack/templates/"$_TEMPLATE_NAME"
    _REMOTE_TEMPLATE='https://raw.githubusercontent.com/sboosali/config/master/stack/templates/'"$_TEMPLATE_NAME"
    if [ -f "$_LOCAL_TEMPLATE" ]; then
	_TEMPLATE=$_LOCAL_TEMPLATE
    else
	_TEMPLATE=$_REMOTE_TEMPLATE
    fi

    _FILE="$_NAME".exe.hs

    stack new "$_NAME" "$_TEMPLATE"
    cd "$_NAME"
    chmod u+x "$_FILE"
    ./"$_FILE"
    $EDITOR "$_FILE" &disown

}

function hd () {
stack haddock --open --keep-going 
}

# New project scaffolding
function hnew () {
    PACKAGE="$1"
    MODULE="$2"
    _FILEPATH="$3"

    MESSAGE='hnew PACKAGE MODULE FILEPATH''\n''e.g. hnew workflow-derived Workflow.Derived Workflow/Derived'

    if [ "$#" -ne 3 ]; then
        echo -e $MESSAGE
	return 1
    fi

    LOCAL_TEMPLATE=~/.stack/templates/spirosboosalis.hsfiles
    REMOTE_TEMPLATE='https://raw.githubusercontent.com/sboosali/config/master/stack/templates/spirosboosalis.hsfiles'
    if [ -f "$LOCAL_TEMPLATE" ]; then
	TEMPLATE=$LOCAL_TEMPLATE
    else
	TEMPLATE=$REMOTE_TEMPLATE
    fi
    
    stack new $PACKAGE $TEMPLATE -pmodule:$MODULE -pfilepath:$_FILEPATH
    cd $PACKAGE
    if [ "$?" -ne 0 ]; then
        echo -e $MESSAGE
	return 1
    fi

    echo $PACKAGE | copy
    $BROWSER http://github.com/new # create repository, manually

    stack build
    stack exec -- example-$PACKAGE

    git init
    git add .
    git commit -m"1st"
    git remote add origin git@github.com:sboosali/"$PACKAGE".git # https://github.com/sboosali/$PACKAGE.git
    git push -u origin master

    # open sources/$MODULE/Example.hs
}

# To generate a Nix build expression for it, change into the project’s top-level directory and run the command:
# $ cabal2nix . >foo.nix
# Then write the following snippet into a file called default.nix:
# { nixpkgs ? import <nixpkgs> {}, compiler ? "ghc7102" }:
# nixpkgs.pkgs.haskell.packages.${compiler}.callPackage ./foo.nix { }
# Finally, store the following code in a file called shell.nix:
# { nixpkgs ? import <nixpkgs> {}, compiler ? "ghc7102" }:
# (import ./default.nix { inherit nixpkgs compiler; }).env

function h2n() {

cabal2nix . > package.nix
# package.nix gets overwritten
# default.nix and shell.nix don't get overwritten, if present

if [[ ! -f default.nix ]]; then
cat <<EOF > default.nix
{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc802" }:
nixpkgs.pkgs.haskell.packages.\${compiler}.callPackage ./package.nix { }
EOF
fi

if [[ ! -f shell.nix ]]; then  # `-f` caveat: http://stackoverflow.com/questions/638975/how-do-i-tell-if-a-regular-file-does-not-exist-in-bash
cat <<EOF > shell.nix
{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  f = import ./default.nix;
  ps = {
    spiros = ~/spiros; # absolute
  };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.\${compiler};

  drv = haskellPackages.callPackage f ps;

in

  if pkgs.lib.inNixShell then drv.env else drv
EOF
fi
}

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

########################################
## MORE DEFINITIONS

DIV="\n\n--------------------------------------------------------------------------------\n\n"

function dog {
 SEP="--------------------------------------------------------"
 while read file; do
     if [ -f "$file" ]; then
         echo -e "\n"$SEP
         echo "$file"
         echo -e $SEP"\n"
         cat "$file"
     fi
 done
}

function show-variable () {
echo "$1" | tr ':' '\n'
}

# Pretty print the path
function show-path () {
echo $PATH | tr ':' '\n'
}

# needs curl
function download {
    URL=$1
    FILE=`basename $1`
    curl $URL > $FILE
}

function cobra () {
python -c "
import sys
x = list(sys.stdin)[0].strip().split()
print($@)
"
}

function space () {
stat -f%z "$@" | '(float(x[0])/1e9, "gigabytes")'
}

# absolute path
function absolute-path {
 echo $(readlink -f "$1")
 # echo $(cd $(dirname "$1"); pwd)/$(basename "$1")
}
alias path='absolute-path'
 
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
        echo $_MESSAGE
	return 1
fi
ssh-add ~/.ssh/$1
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
 FILE=$1
 LINE=$2
 git show $(git blame "$FILE" -L $LINE,$LINE | awk '{print $1}')
}

function clone () {
# use ssh
_GITHUB_USER=$1
_GITHUB_REPOSITORY=$2
_MESSAGE='clone USER REPOSITORY'
if [ "$#" -ne 2 ]; then
        echo $_MESSAGE
	return 1
fi
git clone git@github.com:"$_GITHUB_USER"/"$_GITHUB_REPOSITORY".git
cd "$_GITHUB_REPOSITORY"
}

# submodule
function git-mod () {
_GITHUB_REPOSITORY=$1
_MESSAGE='git-mod REPOSITORY'
if [ "$#" -ne 1 ]; then
        echo $_MESSAGE
	return 1
fi
git submodule add git@github.com:sboosali/"$_GITHUB_REPOSITORY".git "$_GITHUB_REPOSITORY"
}

# e.g.
# git remote set-url origin $( make-github-ssh sboosali .emacs.d)
function make-github-ssh () {
_GITHUB_USER=$1
_GITHUB_REPOSITORY=$2
git@github.com:"$_GITHUB_USER"/"$_GITHUB_REPOSITORY".git
}

# git subtree add -P <prefix> <repo> <rev>
function git-merge-repos () {
_MESSAGE='git-merge-repos <prefix> <repo> <rev> (to be merged into the current one)'
if [ "$#" -ne 3 ]; then
        echo $_MESSAGE
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

########################################
## X

# eDP-1-1 is name of the laptop screen (the first field)
# "Why is it called eDP? bcause it is an embedded display port style adapter, and not a video graphics array style one."
# 0x42 is the Identifier from `xrandr --verbose`
# alias red="xrandr --output 0x42 --crtc 0 --gamma "
# xrandr -d :0 --output eDP-1-1 --gamma "1:1:1" # restore default
# xrandr -d :0 --output eDP-1-1 --gamma "1:1:1"
alias red="redshift -O 1000" # one-shot, 1000K
alias un-red="redshift -x" # 
alias orange="redshift -O 2000" # one-shot
alias yellow="redshift -O 3000" # one-shot

########################################
## 
