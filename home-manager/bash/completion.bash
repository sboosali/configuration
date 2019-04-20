#!/usr/env bash

#------------------------------------------------#
# Variables -------------------------------------#
#------------------------------------------------#

CompletionDirectory="${XDG_DATA_HOME:-$HOME/.local/share}"/bash/completions

#------------------------------------------------#
# Functions -------------------------------------#
#------------------------------------------------#

function sboo-source-bash-completions-xdg ()
{
    local CompletionFile

    if   [[ -d "${CompletionDirectory}" ]]
    then

        for CompletionFile in "${CompletionDirectory}"/*
        do

            CompletionFile=$(readlink -f "${CompletionFile}")

            if   [[ -f "${CompletionFile}" ]] && [[ -r "${CompletionFile}" ]]
                 # ^ ① is a file and ② can be read.
            then

                # shellcheck source=/dev/null
                source "${CompletionFile}" || true

            fi
        done
    fi

}

#------------------------------------------------#
# Effects ---------------------------------------#
#------------------------------------------------#

sboo-source-bash-completions-xdg

#------------------------------------------------#
# EOF -------------------------------------------#
#------------------------------------------------#
