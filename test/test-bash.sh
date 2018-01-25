#!/bin/bash
########################################

# run with:
#
# $ ./test/ test-bash.sh
# $ $?
# 0
#
# "$?" is "0" on success

########################################

cd ./bash || exit

# everything is checked, even if one fails
shellcheck -x    .bashrc
shellcheck       .bash_definitions.sh
shellcheck       .bash_settings.sh
shellcheck -s sh .aliases 
shellcheck       .bash_logout

cd .. 

########################################

cd ./test || exit

shellcheck -x    test-bash.sh # check self

########################################
