#!/bin/bash

# absolute path
function _get_absolute_path {
 echo $(cd $(dirname "$1"); pwd)/$(basename "$1")
}
# (internal helper function)
# e.g. echo `_get_absolute_path ~`

# declare -r -a MY_CONFIGURATION_LINKS=($'"./bash/.bashrc" "~/.bashrc"' ...)

# subshell preserve's (super)shell's pwd
eval $(cd dhall  &&  cat links.dhall | dhall-to-bash --explain --declare MY_CONFIGURATION_LINKS)

echo "[SYMBOLICALLY LINKING]"

for l in ${MY_CONFIGURATION_LINKS[@]}; do
  MY_SOURCE=$(_get_absolute_path $(echo $l | cut -d':' -f1))
  MY_LINK=`echo $l | cut -d':' -f2`
  echo 
  echo "$MY_LINK  ->  $MY_SOURCE"
  # ln -s $MY_SOURCE $MY_LINK
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
