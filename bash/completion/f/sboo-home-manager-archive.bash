#!/bin/env bash

#------------------------------------------------#
# Code ------------------------------------------#
#------------------------------------------------#

# shellcheck disable=SC2207
_sboo-home-manager-archive_completions ()
{
    #--------------------------#

    local CurrentWord
    local HMGenerations

    #--------------------------#

    CurrentWord="${COMP_WORDS[$COMP_CWORD]}"

    # ^ the word currently being completed

    #--------------------------#

    HMGenerations=( $(home-manager generations  |  sed -n -e 's/^................ : id \([[:alnum:]]\+\) -> .*/\1/p') )

    # ^ e.g.
    #   « 2019-04-29 03:39 : id 326 -> /nix/store/pjqav8m4rjvix0z9q7vzxjlm0j7jjd6z-home-manager-generation »

    COMPREPLY=()
    COMPREPLY+=( $( compgen -W "${HMGenerations[*]}" -- "$CurrentWord" ) )

    #--------------------------#
}

#------------------------------------------------#

complete  -F _sboo-home-manager-archive_completions  -o default  sboo-home-manager-archive
