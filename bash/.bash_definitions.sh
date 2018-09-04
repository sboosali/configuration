#!/bin/bash

# set -u 
# which will cause any unset argument reference to immediately fail the script.

############################################################
############################################################
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

############################################################
############################################################
## DEFINITIONS: TOUCH / MKDIR

function brush () {
  # synonym for "touch"
  mkdir -p "$(dirname "$1")"
  touch "$1"
}

function brush-executable () {
  brush "$1"
  chmod +x "$1"
}


############################################################
############################################################
## DEFINITIONS: CD

function cd-ls () {
 cd $@ && echo '--------------------------------------------------------------------------------' && pwd && echo '--------------------------------------------------------------------------------' && echo && ls

}

# short

# cd
# d == cd == 'cd ~'

############################################################
############################################################
## DEFINITIONS: LS

# ls 

############################################################
############################################################
## DEFINITIONS: FIND

function find-verbose() {
 find $@ -printf "%p  |  %u  |  %g %m  |  %M \n"
 #
 # e.g.
 #   $ ls-permissions /dev/vboxdrv
 #   /dev/vboxdrv  |  root  |  root 600  |  crw------- 
 #
}

function find-executables() {
 find $@ -executable -type f -printf "%M | %p\n"
}

function find-relevant () {
    # `find` only "relevant" files, i.e. skipping
    # some build directories (like `dist-newstyle/`)
    # and hidden directories (like `.git/`).
    find $@  -type f  \( -path '.git' -o -path '.stack-work' -o -path 'dist' -o -path 'dist-*' \) -prune  -o -print
    # -a -not -path './'
    #TODO
}

function find-by-extension() {
 FILE_EXTENSION="${1:?'[ERROR] missing argument: FILE_EXTENSION'}"
 find . -type f -name "*.${FILE_EXTENSION}" -printf "| %p\n"
}

function ls-permissions() {
 find . -maxdepth 1 -printf "%M | %p\n"
}

function ls-directories() {
 echo
 find . -maxdepth 1 -type d -not -name '.*' -printf "%p\n"
}

function ls-files() {
 find . -maxdepth 1 -type f -printf "%M | %p\n"
}

 ##OLD: `ls --almost-all -l`




############################################################
############################################################
## DEFINITIONS: GREP


############################################################
############################################################

# cat
function copy-file() {
  FILE="${1:?}"
  cat "$FILE" | xclip -selection clipboard
  cat "$FILE"
}

# grep

# create parent directories by default

function mdcd() {
 ##########
 MESSAGE="[ERROR] Missing parameter. [USAGE] {{{ mdcd <path> }}}. [ACTION] {{{ mkdir _ && cd _ }}}."
 ##########
 DIRECTORY="${1:?${MESSAGE}}"
 mkdir -pv "$DIRECTORY" || true
 cd "$DIRECTORY" && ls -lA
 ##########
}

###########################################################
#############################################################
## Clipboard / Editor

# copy/paste

# xbrightness

# workflow
# 
function open () {
  xdg-open &disown
}

# keybindings

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

function emacs-terminal () {

    EMACS_FLAGS="-nw"
    # 
    #     EMACS_FLAGS=""
    #     EMACS_FLAGS="-nw"

    # USAGE
    #
    # $ emacs-terminal FILE:LINE:COL

    echo '----------------------------------------'
    echo

    if   [[ ! -z "$1" ]]
         # ^ are there any arguments? (i.e. is there a first argument?)

    then
        IFS=':' read -r FILE LINE COLUMN <<< "$1"
        if   [[ -e "$FILE" ]]
             # ^ is this a path and does that path exist?    
        then
            # ^ parse (e.g.) ./dir/file.txt:10:80
            echo '[FILE   = ]' "$FILE"
            echo '[LINE   = ]' "$LINE"
            echo '[COLUMN = ]' "$COLUMN"
            echo
            #
            if   [[ ! -z "$LINE" && ! -z "$COLUMN" ]]
            then
                 shift 1
                 emacs "${EMACS_FLAGS}" "+$LINE:$COLUMN" "$FILE" "$@"
            elif [[ ! -z "$LINE" ]]
            then
                 shift 1
                 emacs "${EMACS_FLAGS}" "+$LINE" "$FILE" "$@"
            else
                 shift 1
                 emacs "${EMACS_FLAGS}" "$FILE" "$@"
            fi
        else
            emacs "${EMACS_FLAGS}" "$@"
        fi

    else
        # no command-line arguments
        emacs "${EMACS_FLAGS}" . "$@"
        # ^ open current-directory in `dired`                                                     
    fi

    echo '----------------------------------------'
    echo

    ##NOTES                        
    #                              
    # $ emacs +LINE:COLUMN FILE    
    # open FILE at line LINE, column COLUMN
    #
    # `shift 1`
    # pass the rest of the arguments through to the program;
    # i.e. "@{2..}".
    # 
    #
}

# nano

# Reloading
# mnemonic: "s" for sourcing
#
#

function se () {
    (cd ~/.emacs.d && nix-build emacs.nix && ./result/bin/emacs --debug-init)
}

############################################################
############################################################
# Remove

# rm
#
#
#

############################################################
############################################################
# Miscellaneous Builtins/Programs

# chmod

# help aliases

# misc
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

# e.g. cpr stuff backup
# ./backup/stuff doesn't exist yet and is created
# --exclude ".stack-work" --exclude "dist-newstyle"


#

# Natural Language Commands

    # e.g. 
    #
    #      $ cd ~
    #      $ synchronize haskell/spiros/sources ~/backup
    #
    # wildcards work:
    #
    #      $ synchronize haskell/commands/commands-spiros/config* ~/backup/
    #      # includes: config/ config-linux/ config-osx/ config-windows/

    # 



## pass options to free ##
## get top process eating memory
## get top process eating cpu ##
## Get server cpu info ##
## get GPU ram on desktop / laptop##

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

# python

############################################################
############################################################
## GIT

# git

# # cleaning TODO


############################################################
############################################################
# Temporary Directories/File
# (By Name/Extension)

function find-temporaries () {
 # dry-run for `rm-temporaries`
 find .  -type f  \( -name '*~' -o -name '\#*\#' -o -name '.\#*' \)  -print  $@
}

function rm-temporaries() {
 # remove temporary files recursively
 # emacs temp files: '*~ .*~ \#*\# .\#*'

 find-temporaries -delete

 # print whatever's deleted

 # If your OS isn't Linux, replace -delete by -exec rm {} +.

 # find . -name \*~ | xargs rm
}



############################################################
############################################################
## NIX

#
#
#
#
#
#
#
  # recursively evaluate list elements and attributes
  # NOTE may loop
           # Interpret the command line arguments as a list of Nix expressions to be parsed and evaluated, rather than as a list of
           # file names of Nix expressions. 

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


# "nix-channel --update"



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


function nix-install-haskell() {
 nix-env -f "<nixpkgs>" -i -A "haskellPackages.${1:?}"
}

function garbage-collect() {
 nix-collect-garbage
 echo
 disksize
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
function sboo-nix-repl () {

 read -r -d '' NIX_REPL_EXAMPLES <<EOF

''
##################################################
''

nixpkgs = import <nixpkgs> {}
b       = builtins
c       = nixpkgs.config
l       = nixpkgs.lib
self    = nixpkgs.pkgs

h    = nixpkgs.haskell.lib
hs   = nixpkgs.pkgs.haskellPackages
hs86 = nixpkgs.pkgs.haskell.packages.ghc861

el   = nixpkgs.pkgs.emacs26Packages
el26 = nixpkgs.pkgs.emacs26Packages

py   = nixpkgs.pkgs.python27Packages
py27 = nixpkgs.pkgs.python27Packages

:a nixpkgs
:a nixpkgs.lib

melpaBuild = nixpkgs.pkgs.emacs26Packages.emacsMelpa.melpaBuild
melpa      = nixpkgs.pkgs.emacs26Packages.emacsMelpa

kde    = nixpkgs.plasma5

sboo   = nixpkgs.sboo
sbooHaskell = nixpkgs.sboo.haskellPackages

''
##################################################
''
EOF

# p.kdeApplications 
# p.kdeFrameworks
# :i sbooHaskell.spiros

  echo
  echo -e "$NIX_REPL_EXAMPLES"
  echo

  if   [ -x "$(command -v xdotool)" ]
  then
      (sleep 1 && xdotool type --clearmodifiers 'nixpkgs = import <nixpkgs> {}' && xdotool key --clearmodifiers 'Return' && xdotool type --clearmodifiers ':a nixpkgs' && xdotool key --clearmodifiers 'Return' && xdotool type --clearmodifiers 'hs = nixpkgs.pkgs.haskellPackages' && xdotool key --clearmodifiers 'Return' && xdotool type --clearmodifiers 'py = nixpkgs.pkgs.pythonPackages' && xdotool key --clearmodifiers 'Return' && xdotool type --clearmodifiers 'el = nixpkgs.pkgs.emacs26Packages' && xdotool key --clearmodifiers 'Return' && xdotool type --clearmodifiers 'kde = nixpkgs.plasma5' && xdotool key --clearmodifiers 'Return' && xdotool type --clearmodifiers 'melpa = nixpkgs.pkgs.emacs26Packages.emacsMelpa' && xdotool key --clearmodifiers 'Return') &
     # ^ [template]
     #   && xdotool type --clearmodifiers ' = nixpkgs.pkgs.' && xdotool key --clearmodifiers 'Return'

  fi
  
  # nix-repl # Nix v1
  nix repl   # Nix v2

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

function prefetch-github () {

URL="${1:?}"

NAME=$(basename "$URL")

FILE="$NAME.json"

nix-prefetch-git "$URL" > "$FILE"

cat "$FILE"

}

############################################################
############################################################
## X11

function raise-window () {
 if   command -v wmctrl;

 then _TITLE="${1}"
      wmctrl -a "${_TITLE}"

 else echo '[ERROR] the `wmctrl` command must be present. you can install it with `nix-env -i wmctrl`.'
 fi
}

function raise-emacs () {
 raise-window "${1:-emacs}"
}

function raise-browser () {
 raise-window "${1:-chrome}"
}

function raise-terminal () {
 raise-window "${1:-terminal}"
}


#  wmctrl  -b add,fullscreen  -a "${_TITLE}"

############################################################
############################################################
## HASKELL

## haskell

# function he() { 
#  stack exec -- "$@" 
# }

############################################################
############################################################
# Make / Makefiles

#
#
#
#
#

############################################################
############################################################
# Haskell

#
#

# stack


# `cabal new-*`
#
# with arguments order reversed,
# i.e., first the PACKAGE, then the COMMAND.
# 
# e.g.
# 
# $ haskell-build 
# cabal new-build all
# 
# $ haskell-build backend
# cabal new-build backend
# 
# $ haskell-build common test
# cabal new-test common
# 
# 
function haskell-build() {
 cabal "new-${2:-build}" "${1:-all}"
}


# e.g.
# 
# $ haskell-nix-build 
# # nix-shell --run "cabal new-build all"
# 
# $ haskell-nix-build backend
# # nix-shell --run "cabal new-build backend"
# 
# also see `haskellPackages.shellFor`
# 
# 
function haskell-nix-build() {
 nix-shell --run "cabal new-build ${1:-all}"
}


# e.g.
# 
# $ h2 
# # cabal new-build all
# 
# $ h2 test
# # cabal new-test all
# 
# $ h2 test backend
# # cabal new-test backend
#
function h2() {
 cabal "new-${1:-build}" "${2:-all}"
}


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

# function ht() {
#     PACKAGE="$(basename "$PWD")"
#     stack build && _printDiv && stack test
# }

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

function project2nix() { 

 _PACKAGES="$@"
 _PACKAGE="$1" #TODO array, and loop.

 read -r -d '' DEFAULT_NIX <<EOF
########################################
{ nixpkgs       
   ? import <nixpkgs> { }
   # ? import ./nixpkgs {}

# , compilerName   ? null  # :: Maybe String 
# , compilerFlavor ? null  # :: Maybe String

}:
########################################
let

projectPacakges = {

 ${_PACKAGE} = ./${_PACKAGE};

};

haskellPackages =
 nixpkgs.haskellPackages.extend
  (nixpkgs.haskell.lib.packageSourceOverrides
    projectPacakges);

in
########################################

haskellPackages

########################################
EOF
 # (^ set variable to heredoc)
 
 read -r -d '' SHELL_NIX <<EOF
########################################
arguments@
{ nixpkgs       
   ? import <nixpkgs> { }

, system
   ? builtins.currentSystem

, ...
}:
########################################
let

haskellPackages =
 (import ./.) { inherit nixpkgs; };

projectEnvironment =
  haskellPackages.shellFor {
    withHoogle = true;
    packages = self: with self;
      [
        (${_PACKAGES})
      ];
  };

in
########################################

projectEnvironment

########################################
EOF

echo
echo '--------------------------------------------------------------------------------'
echo '[shell.nix]'
echo
echo "$SHELL_NIX" > shell.nix
cat shell.nix

echo
echo '--------------------------------------------------------------------------------'
echo '[default.nix]'
echo
echo "$DEFAULT_NIX" > default.nix
cat default.nix

echo
echo '--------------------------------------------------------------------------------'

nix-shell shell.nix

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
 
############################################################
############################################################
## Formatting in Bash

function _printDiv () {
  printf '\n\n'
  printf "%s" '----------------------------------------'
  printf '\n\n'
}

function dog {
    THICK_SEPARATOR="========================================================"
    THIN_SEPARATOR="--------------------------------------------------------"

    FILES="${@:-$(ls ./.)}" #TODO
    
    for FILE in "${FILES}"
    do
        if [ -f "$FILE" ]
        then
            echo -e "\n${THICK_SEPARATOR}"
            echo "$FILE"
            echo -e "${THIN_SEPARATOR}\n"
            cat "$FILE"
        fi
    done
    echo -e "\n${THICK_SEPARATOR}"
} # ^ `cat` each `FILE` argument.

function show-variable () {
 echo "$1" | tr ':' '\n'
}

# Pretty print the path
function show-path () {
 echo "$PATH" | tr ':' '\n'
}

############################################################
############################################################
# Process stuff

function exec-named() {
    HELP="[Usage] exec-named NAME COMMAND"
    NAME=${1:?"provide a NAME argument; $HELP"}
    COMMAND=${2:?"provide a COMMAND argument; $HELP"}
    bash -c "exec -a '$NAME' '$COMMAND' &"
}

function kill-named() {
    HELP="[Usage] kill-named NAME"
    NAME=${1:?"provide a NAME argument; $HELP"}
    pkill -f "$NAME"
}

############################################################
############################################################
## Miscellaneous

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

############################################################
############################################################
## SSH

# https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
GPG_TTY=$(tty)
export GPG_TTY

# for github
#
# http://stackoverflow.com/questions/9607295/how-do-i-find-my-rsa-key-fingerprint
function ssh-fingerprint () {
 ssh-keygen -E md5 -lf "$1.pub"
} 


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

############################################################
############################################################
## Git / GitHub 

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

function github-set-upstream() {
 # after cloning fork
 local OWNER="${1-?}"
 local REPOSITORY="${2-?}"

 echo
 git remote -v
 
 echo
 git remote add upstream https://github.com/"$OWNER"/"$REPOSITORY".git

 echo
 git remote -v
}
  # $ git remote -v
  # origin	https://github.com/sboosali/nixpkgs (fetch)
  # origin	https://github.com/sboosali/nixpkgs (push)
  # upstream	https://github.com/NixOS/nixpkgs.git (fetch)
  # upstream	https://github.com/NixOS/nixpkgs.git (push)

function git-rebase-upstream() {
 # for updating a fork
 git pull --rebase upstream master
 # rebase master onto upstream
}


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
set -o errexit
set -o nounset
########################################

MESSAGE="Usage: {{{ $ ./$FILENAME FILENAME }}}"

FILENAME="${1:?${MESSAGE}}"

########################################

echo "$FILENAME"

########################################
## NOTES

########################################
EOF
 
 chmod 700 "$FILENAME"
 emacsclient "$FILENAME" &
}

function kill-baloo() {

balooctl status
balooctl disable
rm -rf ~/.local/share/baloo

}

############################################################
############################################################
# Linux Groups/Users

function group-exists {
  if [ $(getent group $1) ]; then
    echo "[YES] group \`$1\` exists."
  else
    echo "[NO] group  \`$1\ does not exist."
  fi
}

function group-has-user {

  MESSAGE='group-has-user GROUP [NAME]'

  case "$#" in

        0 )
            echo '----------------------------------------'
            echo >&2 "$MESSAGE"
            echo '----------------------------------------'
            exit 1
            ;;
        
        1 )
            GROUP="${1}"
            USER=$(whoami)
            ;;

        2 )
            GROUP="${1}"
            USER="${2}"
            ;;

        * )
            echo '----------------------------------------'
            echo >&2 "$MESSAGE"
            echo '----------------------------------------'
            exit 1
            ;;
  esac

  echo '----------------------------------------'
  echo "[GROUP =] $GROUP"
  echo "[USER  =] $USER"
  echo '----------------------------------------'

  if  id --name --groups --zero "$USER" | grep --quiet --null-data --line-regexp --fixed-strings "$GROUP"
      # ^ `id` outputs null-seperated-values, `grep` splits lines on the null-character.
  then
      echo "[MEMBERSHIP =] YES"
      echo "(User \`$USER' belongs to group \`$GROUP')"
  else
      echo "[MEMBERSHIP =] NO"
      echo "(User \`$USER' does not belong to group \`$GROUP')"
  fi

  echo '----------------------------------------'
}

############################################################
############################################################
# BashCompletion

function bash-completion--source-something () {

  echo "sourcing ~/.nix-profile/share/bash-completion/completions/$1"
  echo 

  source ~/.nix-profile/share/bash-completion/completions/$1

}

function bash-completion--source-everything () {

  ##########
  # _/etc

  echo 'sourcing ~/.nix-profile/etc/bash_completion.d/*'

  COMPLETION_DIRECTORY_ETC=~/.nix-profile/etc/bash_completion.d
  
  for COMPLETION_ETC in "$COMPLETION_DIRECTORY_ETC"/*
  do
      source "$COMPLETION_ETC" || true
  done

  ##########
  # _/share
  
  echo 'sourcing ~/.nix-profile/share/bash-completion/completions/*'

  COMPLETION_DIRECTORY_SHARE=~/.nix-profile/share/bash-completion/completions
  
  for COMPLETION_SHARE in "$COMPLETION_DIRECTORY_SHARE"/*
  do
      source "$COMPLETION_SHARE" || true
  done

  ##########  
  # ~/.nix-profile/etc/bash_completion.d/*
  # ~/.nix-profile/share/bash-completion/completions/*
  
}

############################################################
############################################################
## EMACS


############################################################
############################################################
## SCREEN COLOR/BRIGHTNESS MANIPULATION (X11)

function get-brightness--via-sysclass () {
 cat /sys/class/backlight/intel_backlight/brightness
}

# function screen-dim--via-sysclass () {
#  echo 500 > /sys/class/backlight/intel_backlight/brightness
# }

function screen-brighter--via-xdotool () {
 printf "BRIGHTNESS = %d\n" $(get-brightness--via-sysclass)
 printf 'BRIGHTENING..\n'
 # `echo` without newline
 for i in `seq "${1:-10}"`; do 
  # repeat <n> times
  xdotool key XF86MonBrightnessUp
  # briefly pausing (10ms)
  sleep 0.033
  # print ellipsis
  printf '.'
 done
 printf ' BRIGHTENED\n'
 sleep 0.017
 # pause briefly after the setting the brightness, before reading the brightness.
 printf "BRIGHTNESS = %d\n" $(get-brightness--via-sysclass)
}

function screen-dimmer--via-xdotool () {
 printf "BRIGHTNESS = %d\n" $(get-brightness--via-sysclass)
 printf 'DIMMING...'
 # `echo` without newline
 for i in `seq "${1:-10}"`; do 
  # repeat <n> times
  xdotool key XF86MonBrightnessDown
  # briefly pausing
  sleep 0.033
  # print ellipsis
  printf '.'
 done
 printf ' DIMMED\n'
 sleep 0.017
 # pause briefly after the setting the brightness, before reading the brightness.
 printf "BRIGHTNESS = %d\n" $(get-brightness--via-sysclass)
}

# eDP-1-1 is name of the laptop screen (the first field)
# "Why is it called eDP? bcause it is an embedded display port style adapter, and not a video graphics array style one."
# 0x42 is the Identifier from `xrandr --verbose`
# xrandr -d :0 --output eDP-1-1 --gamma "1:1:1" # restore default
# xrandr -d :0 --output eDP-1-1 --gamma "1:1:1"


# ^ via: redshift; xrandr-invert-colors; and xdotool (XF86MonBrightnessDown).



#

function screen-set () {
 redshift -O "${1}00"
}

##################################################
# DirEnv #########################################
##################################################


# $ direnv allow


##################################################
# ssh-agent ######################################
##################################################

##########
# (1) 
# Start the ssh-agent in the background:

# $ eval "$(ssh-agent -s)"
#
# NOTE see
#    ./.bash_settings.sh
#

# ^ e.g. stdout:
#     Agent pid 59566

##########
# (2) 
# Add your SSH private key to the ssh-agent.


#TODO 
#PRIVATE_KEY_FILENAME=id_rsa
#ssh-add -K ~/.ssh/"${PRIVATE_KEY_FILENAME}"
# ^ `-K` is OSX-only.

##########
# NOTES: ssh-agent

# `ssh-agent` it's a program that runs in the background, and keeps your key loaded into memory, so that you don't need to enter your passphrase every time you need to use the key.
#
#

# $ ssh-add -l
# e.g.
#      4096 SHA256:pW34+/3i9OON5bFkv/qZ5jBRddAfXv5qMXiBko+fWZ8 /home/sboo/.ssh/id_rsa (RSA)
#

# See
#    - https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
# 

############################################################
############################################################
## Restarting Services

# ^ seems to be always necessary after startup; 
# otherwise, clicking on the windows bars at the bottom of the screen
# doesn't switch to those windows

#


#
# either:
#
#   $ killall plasmashell && kstart plasmashell
#
# or:
#
#   $ kquitapp5 plasmashell && kstart plasmashell
#

############################################################
############################################################
# Ephemeral/Specialized Stuff

#TODO rm

# apt list --upgradeable 

############################################################
############################################################
# NOTES About ShellCheck

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

  # id --name --groups --zero "$USER" | grep --quiet --null-data --line-regexp --fixed-strings "$GROUP"
  # # ^ `id` outputs null-seperated-values, `grep` splits lines on the null-character.
  # MEMBERSHIP="$?"
  # # ^ TODO safe?

############################################################
############################################################

if [ -f  ~/.aliases ]; then
  source ~/.aliases
fi

if [ -f  ~/.bash_aliases.sh ]; then
  source ~/.bash_aliases.sh
fi

############################################################
############################################################