#!/bin/bash

LINK_OPTIONS=$1 # no force by default
# LINK_OPTIONS=${1:-"-f"} # force by default
echo "[OPTIONS] $LINK_OPTIONS"
echo

# absolute path
function _get_absolute_path {
 echo $(readlink -f "$1")
}
# (internal helper function)
# e.g. echo `_get_absolute_path ~`

# declare -r -a MY_CONFIGURATION_LINKS=($'"./bash/.bashrc" "~/.bashrc"' ...)

# subshell preserve's (super)shell's pwd
eval $(cd dhall  &&  cat links.dhall | dhall-to-bash --explain --declare MY_CONFIGURATION_LINKS)

echo
echo '----------------------------------------'
echo "[DIFFING]"
echo

for l in ${MY_CONFIGURATION_LINKS[@]}; do
  MY_SOURCE=$(echo $l | cut -d':' -f1 | xargs readlink -f)
  MY_LINK=$(echo $l | cut -d':' -f2 | xargs echo) # | xargs readlink -f)
  MY_LINK=${MY_LINK/#\~/$HOME}  # "unquote, e.g. "~" to ~
  echo 
  echo "[ $MY_LINK  versus  $MY_SOURCE ]"
  echo
  diff $MY_SOURCE $MY_LINK
done

echo
echo '----------------------------------------'
echo "[SYMBOLICALLY LINKING]"
echo

for l in ${MY_CONFIGURATION_LINKS[@]}; do
  MY_SOURCE=$(echo $l | cut -d':' -f1 | xargs readlink -f)
  MY_LINK=$(echo $l | cut -d':' -f2 | xargs echo) # | xargs readlink -f)
  MY_LINK=${MY_LINK/#\~/$HOME}  # "unquote, e.g. "~" to ~
  echo 
  echo "[ $MY_LINK  ->  $MY_SOURCE ]"
  mkdir -p $(dirname $MY_LINK)
  ln -s $LINK_OPTIONS $MY_SOURCE $MY_LINK
  # echo $MY_SOURCE
  # echo $MY_LINK
  # echo 
done

########################################

# cat configuration.dhall | dhall-to-bash --declare CONFIGURATION > configuration.sh  &&  cat configuration.sh
# cat configuration.dhall | dhall-to-bash | xargs echo -e > configuration.sh  &&  cat configuration.sh
# cat configuration.dhall | dhall-to-bash | xargs echo -e > configuration.sh  &&  cat configuration.sh

# cat links.dhall | dhall-to-bash --explain --declare MY_CONFIGURATION_LINKS | eval
# echo $MY_CONFIGURATION_LINKS

# echo ${MY_CONFIGURATION_LINKS[*]}

# cat links.dhall | dhall-to-bash --explain --declare MY_VARIABLE > links.sh  &&  source links.sh

# # absolute path
# function _get_absolute_path {
#  echo $(cd $(dirname "$1"); pwd)/$(basename "$1")
# }

# MY_VARIABLE="${1:-MY_CONFIGURATION_LINKS}"

# $ readlink -f "~/.gitconfig" 
# $ readlink -f ~/.gitconfig 
# /home/sboo/.gitconfig
