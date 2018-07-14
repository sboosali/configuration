#!/bin/bash
set -e

########################################

ARGUMENTS="$@"

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


function safe-link-file () {

 INPUT=$(true-absolute-path "$1")
 OUTPUT=$(raw-absolute-path "$2")

 echo
 echo '----------------------------------------' 
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
 
 LINK_COMMAND=( ln "$ARGUMENTS" -s --no-dereference "$INPUT" "$OUTPUT" )
 echo "${LINK_COMMAND[@]}"

 echo
 eval ${LINK_COMMAND[@]}
}



function safe-link () {
 
 INPUT=$(true-absolute-path "$1")
 OUTPUT=$(raw-absolute-path "$2")

 echo
 echo '----------------------------------------' 
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
 
 LINK_COMMAND=( ln "$ARGUMENTS" -s --no-dereference "$INPUT" "$OUTPUT" )
 echo "${LINK_COMMAND[@]}"

 echo
 eval ${LINK_COMMAND[@]}
}

########################################
echo

echo '----------------------------------------'
echo '[ARGUMENTS]'
echo "$ARGUMENTS" 
echo 

########################################

safe-link-file "argos" "~/.config/argos" 

safe-link-file "x11/xinitrc" "~/.xinitrc"

########################################
