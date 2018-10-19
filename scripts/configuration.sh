#!/bin/bash
set -e
########################################

function abort () {
  echo '$ ./configuration.sh [--help | --dry-run]'
  exit 1
}

SHOULD_EXECUTE=""

if [[ $# -gt 1 ]];  then
   abort
else
  if [ -z "${1-}" ]; then
     SHOULD_EXECUTE="true"
     # DRY_RUN="false"
  else
    case "$1" in
       --help)
           abort
         ;;
       --dry-run)
           SHOULD_EXECUTE=""
           # DRY_RUN="true"
        ;;
       *) 
           abort
        ;;
    esac
  fi
fi

########################################

# get the absolute path, which symbolic linking requires.

function raw-absolute-path {
 echo $(cd $(dirname "$1"); pwd)/$(basename "$1")

 # versus `readlink`, which
 # /reads links/, which will be by cosntruction identical
}

function true-absolute-path {
 readlink -f "$1"
}

function safe-mkdir () {
 mkdir -p "$(dirname "$1")"
}

function safe-link () {
 
 INPUT=$(true-absolute-path "$1")
 OUTPUT=$(raw-absolute-path "$2")

 echo 
 echo "Source: $INPUT"
 echo "Link:   $OUTPUT"

 if [ -d "$INPUT" ]; then
   if   [ -L "$OUTPUT" ]; then
     echo "ignoring symlink ${OUTPUT}"

   elif [ -e "$OUTPUT" ]; then
     # ^ exists and isn't a symlink

     #TODO it deletes the configuration's subdir
     # echo "removing ${OUTPUT}"
     # rm -r "${OUTPUT:?}"

     echo "${OUTPUT} exists"
       
     # ^ 
     # ''-e "${file}" fails if the symlink exists but its target does not exist.''
     # ''-L returns true if the "file" exists and is a symbolic link (the linked file may or may not exist). You want -f (returns true if file exists and is a regular file) or maybe just -e (returns true if file exists regardless of type).''

   else
     echo "_"
   fi

 else
   echo "creating directories for ${OUTPUT:?}"
   safe-mkdir "$OUTPUT"
 fi
 
 LINK_COMMAND=( ln -sf --no-dereference "$INPUT" "$OUTPUT" )
 echo "${LINK_COMMAND[@]}"

 if [ -z "$SHOULD_EXECUTE" ]; then
   echo
   echo '( --dry-run )'
 else  
   echo
   eval ${LINK_COMMAND[@]}
 fi
}

# e.g.
# INPUT=$(readlink -f ./nix/overlays/)
# OUTPUT=$(readlink -f ~/.config/nixpkgs/overlays/)
# echo "$INPUT"
# echo "$OUTPUT"
# if [ -d "$OUTPUT" ]; then
#  rm -r "${OUTPUT:?}/"
# else
#  mkdir -p "$(dirname "$OUTPUT")"
# fi
# ln -sf --no-dereference "$INPUT" "$OUTPUT"


########################################

# declare -r -a MY_CONFIGURATION_LINKS=($'"./bash/.bashrc" "~/.bashrc"' ...)

# echo
# echo '----------------------------------------'
# echo "[DIFFING]"
# echo

# for l in ${MY_CONFIGURATION_LINKS[@]}; do
#   MY_SOURCE=$(echo $l | cut -d':' -f1 | xargs readlink -f)
#   MY_LINK=$(echo $l | cut -d':' -f2 | xargs echo) # | xargs readlink -f)
#   MY_LINK=${MY_LINK/#\~/$HOME}  # "unquote, e.g. "~" to ~
#   echo 
#   echo "[ $MY_LINK  versus  $MY_SOURCE ]"
#   echo
#   diff $MY_SOURCE $MY_LINK
# done

# echo
# echo '----------------------------------------'
# echo "[SYMBOLICALLY LINKING]"
# echo

# for l in ${MY_CONFIGURATION_LINKS[@]}; do
#   MY_SOURCE=$(echo $l | cut -d':' -f1 | xargs readlink -f)
#   MY_LINK=$(echo $l | cut -d':' -f2 | xargs echo) # | xargs readlink -f)
#   MY_LINK=${MY_LINK/#\~/$HOME}  # "unquote, e.g. "~" to ~
#   echo 
#   echo "[ $MY_LINK  ->  $MY_SOURCE ]"
#   mkdir -p $(dirname $MY_LINK)
#   ln -s $LINK_OPTIONS $MY_SOURCE $MY_LINK
#   # echo $MY_SOURCE
#   # echo $MY_LINK
#   # echo 
# done

# has_t_option=false
# while getopts :ht opt; do
#     case $opt in 
#         h) show_some_help; exit ;;
#         t) has_t_option=true ;;
#         :) echo "Missing argument for option -$OPTARG"; exit 1;;
#        \?) echo "Unknown option -$OPTARG"; exit 1;;
#     esac
# done
# # here's the key part: remove the parsed options from the positional params
# shift $(( OPTIND - 1 ))

LINK_OPTIONS=$1 # no force by default
# LINK_OPTIONS=${1:-"-f"} # force by default

########################################

# files
safe-link ./nix/config.nix                         ~/.config/nixpkgs/config.nix 
safe-link ./nix/nix-channels.txt                   ~/.nix-channels 

safe-link ./bash/.bashrc                           ~/.bashrc 
safe-link ./bash/.aliases                          ~/.aliases 
safe-link ./bash/.profile                          ~/.profile                             
safe-link ./bash/bash_definitions              ~/bash_definitions                    
safe-link ./bash/bash_settings                 ~/bash_settings                       
safe-link ./bash/.bash_logout                      ~/.bash_logout   
safe-link ./bash/.bash_login                       ~/.bash_login

safe-link ./git/.gitconfig                         ~/.gitconfig                           
safe-link ./bash/.git-prompt.sh                    ~/.git-prompt.sh                       

safe-link ./cabal/config.yaml                      ~/.cabal/config                         
safe-link ./stack/config.yaml                      ~/.stack/config.yaml                     
safe-link ./stack/templates/spirosboosalis.hsfiles ~/.stack/templates/spirosboosalis.hsfiles  
safe-link ./stack/templates/spirosboosalis-simple.hsfiles ~/.stack/templates/spirosboosalis-simple.hsfiles  

safe-link ./xbindkeys/.xbindkeysrc.scm             ~/.xbindkeysrc.scm                      
safe-link ./xmodmap/.Xmodmap                       ~/.Xmodmap                              
safe-link ./x11/.xprofile                          ~/.xprofile      
                        

# dirs
safe-link ./nix/overlays ~/.config/nixpkgs/overlays 


#TODO non-home
# safe-link ./nix/global-nix.conf /etc/nix/nix.conf


########################################

# bad
# safe-link ./ghci/ghci.conf                         ~/.ghci                                 
# old
# safe-link ./nix/config.nix                         ~/.nixpkgs/config.nix

########################################
