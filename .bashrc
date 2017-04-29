# .bashrc is for shells that are bash-compatible and interactive

# the relative binary directory for nix-build
export PATH=./result/bin:$PATH

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

alias hs="stack setup"
alias hb="stack build"
function he() { 
 stack exec -- "$@" 
}

alias hcc="cabal configure"
alias hcb="cabal build"

alias d='cd'
alias d-="cd -"
alias d..="cd .."
alias d...="cd ../.."
alias d....="cd ../../.."
alias d.....="cd ../../../.."
alias d......="cd ../../../../.."
alias d.......="cd ../../../../../.."
alias dh='cd ~'
alias dx='cd ~/.xmonad'
alias de='cd ~/.emacs.d'
alias dc='cd ~/configuration'
alias ds='cd ~/speech'
# alias d='cd '

# help aliases
alias lnh="echo 'ln -sf /path/to/file /path/to/symlink'"

alias n=nano
alias f='find'
alias g='git'
alias c='cat'
alias cpr="rsync -arRv" # e.g. cpr stuff backup # ./backup/stuff doesn't exist yet and is created
alias cprd="rsync -arRv --dry-run" # --exclude ".stack-work" --exclude "dist-newstyle"
alias r='rm -r'
alias lnr='readlink -f'
alias lnf='ln -sf' # /path/to/file /path/to/symlink
alias o="echo"
alias t=brush

alias disksize="df -h /"

# copy/paste
alias xc='xclip -selection clipboard'
alias xp='xclip -selection clipboard -o'
alias xb='xbrightness'
alias xbr='xbrightness 65535'

export BROWSER=chromium

#editing
function e() { 
 emacsclient "$1" & 
}
alias ee="emacsclient"
alias en="sudo nano /etc/nixos/configuration.nix && nixos-rebuild build"
alias enr="nano /etc/nixos/configuration.nix"
alias ent="sudo nano /etc/nixos/configuration.nix && sudo nixos-rebuild boot"
alias ens="sudo nano /etc/nixos/configuration.nix && sudo nixos-rebuild switch"
alias enp="cat /etc/nixos/configuration.nix | copy"
alias eb="$EDITOR ~/.bashrc && source ~/.bashrc"
alias ex="$EDITOR .xmonad/xmonad.hs"
#alias e="$EDITOR"
alias ed="emacs --debug-init"
alias eq="emacs -q"
alias edq="emacs -q --debug-init"
alias ec="emacs -q ~/.emacs.d/init.el" # to debug

export EDITOR=emacsclient
function seteditor () {
   export EDITOR="$1"
}

# linux-specific, needs installation
alias open='xdg-open' # &d
alias copy='xclip -selection clipboard'

# Reloading
alias sb="source ~/.bashrc"
alias sn="nixos-rebuild -I nixpkgs=~/nixpkgs/ build"
function se () {
    (cd ~/.emacs.d && nix-build emacs.nix && ./result/bin/emacs --debug-init)
}

alias pwn="sudo chown -R sboo:users"

# Natural Language Commands

alias list="ls -1aFG"
alias remove="rm -f"
alias show="cat"
alias processes="ps -cax -o \"command, pid, %mem, %cpu, user, start, \" "
alias get="git"
alias grab="grep"

alias rm="rm -f"
alias rmr="rm -rf"
alias rmt="rm -f *~ .*~ \#*\# .\#* matlab_crash_dump.* java.log.* *.pyc *.class __pycache__/*.pyc *.agdai *.hi *.hout *.o"

alias c7="chmod 700"

alias psa="ps -cax -o \"command, pid, %mem, %cpu, user, start, \" "

alias ip="ipython"
alias p="python3"
alias p3="python3"
alias p2="python2.7"

alias r="grep -E --color=auto -i"

alias g="git"
alias gl="git status"
alias dif="git dif"
alias ga="git amend"
alias gorc="git status --porcelain | cut -d ' ' -f 2 | tr '\n' ' '"

alias yt='youtube-dl -f 22'

alias unzip="7z x"

function brush () {
# synonym for "touch"
mkdir -p `dirname "$1"`
touch "$1"
}

function show-variable () {
echo "$1" | tr ':' '\n'
}

# Pretty print the path
function show-path () {
echo $PATH | tr ':' '\n'
}

DIV="\n\n--------------------------------------------------------------------------------\n\n"

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
# prunet boot packages  and wired-in
# http://stackoverflow.com/a/10056017/1337806
stack dot --external --prune base,base-orphans,ghc-prim,integer-gmp,integer-simple,hsc2hs,haddock,array,binary,bytestring,Cabal,ghc-compact,containers,deepseq,directory,filepath,haskeline,hoopl,hpc,pretty,process,terminfo,time,transformers,xhtml,parallel,stm,random,primitive,vector,dph,template-haskell,transformers-compat,hashable > $PACKAGE.dot
dot -Tpng -o $PACKAGE.png $PACKAGE.dot 
chromium $PACKAGE.png &d
}

# New project scaffolding
function hnew () {
    PACKAGE="$1"
    MODULE="$2"

    MESSAGE='hnew PACKAGE MODULE'

    if [ "$#" -ne 2 ]; then
        echo $MESSAGE
	return 1
    fi

    LOCAL_TEMPLATE=~/.stack/templates/spirosboosalis.hsfiles
    REMOTE_TEMPLATE='https://raw.githubusercontent.com/sboosali/config/master/stack/templates/spirosboosalis.hsfiles'
    if [ -f "$LOCAL_TEMPLATE" ]; then
	TEMPLATE=$LOCAL_TEMPLATE
    else
	TEMPLATE=$REMOTE_TEMPLATE
    fi
    
    stack new $PACKAGE $TEMPLATE -pmodule:$MODULE
    cd $PACKAGE
    if [ "$?" -ne 0 ]; then
        echo $MESSAGE
	return 1
    fi

    echo $PACKAGE | copy
    open http://github.com/new # create repository, manually

    stack build
    stack exec -- example-$PACKAGE

    git init
    git add .
    git commit -m"1st"
    git remote add origin https://github.com/sboosali/$PACKAGE.git
    git push -u origin master

    # open sources/$MODULE/Example.hs
}

function blame {
 FILE=$1
 LINE=$2
 git show $(git blame "$FILE" -L $LINE,$LINE | awk '{print $1}')
}

# absolute path
function path {
 echo $(cd $(dirname "$1"); pwd)/$(basename "$1")
}

# bash history
export HISTCONTROL=erasedups
export HISTFILESIZE=HISTSIZE=
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

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


function blame {
 FILE=$1
 LINE=$2
 git show $(git blame "$FILE" -L $LINE,$LINE | awk '{print $1}')
}

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

# function space () {
# stat -f "$@" | cobra '(float(x[0])/1e9, "gigabytes")'
# }

function nr () {
  echo 'p = import <nixpkgs> {}'
  echo 'c = (import /etc/nixos/configuration.nix) { inherit (p) pkgs config lib; }'
  nix-repl
}

# https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
GPG_TTY=$(tty)
export GPG_TTY

