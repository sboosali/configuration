#!/bin/env bash

##################################################

# « emacsclient » command-line completion
#
# GPL-3.0-or-later © 2019 "Sam Boosalis" <samboosalis@gmail.com>

##################################################
# Contributing:

# Compatibility — Bash 3.
#
# OSX won't update Bash 3 (last updated circa 2009) to Bash 4,
# and we'd like this completion script to work on both Linux and Mac.
#
# For example, OSX Yosemite (released circa 2014) ships with Bash 3:
#
#  $ echo $BASH_VERSION
#  3.2
#
# While Ubuntu LTS 14.04 (a.k.a. Trusty, also released circa 2016)
# ships with the latest version, Bash 4 (updated circa 2016):
#
#  $ echo $BASH_VERSION
#  4.3
#

# Testing
#
# (1) Invoke « shellcheck »
#
#     * source: « https://github.com/koalaman/shellcheck »
#     * run:    « shellcheck ./share/bash-completion/completions/emacsclient »
#
# (2) Interpret via Bash 3
#
#     * run:    « bash --noprofile --norc ./share/bash-completion/completions/emacsclient »
#

##################################################
# Examples:

# $ emacsclient <TAB>
#
# -V
# --version
# -H
# --help   
# -nw
# -t
# --tty
# -c
# --create-frame   
# -F
# --frame-parameters
# -e
# --eval   
# -n
# --no-wait
# -q
# --quiet
# -u
# --suppress-output
# -d
# --display
# --parent
# -s
# -socket-name
# -f
# --server-file
# -a
# --alternate-editor
# -T
# --tramp
#

##################################################
# Notes:

# « emacsclient » Options:
#
# -V
# --version
#
# -H
# --help   
#
# -nw
# -t
# --tty
#
# -c
# --create-frame   
#
# -F ALIST
# --frame-parameters=ALIST
#
# -e
# --eval   
#
# -n
# --no-wait
#
# -q
# --quiet
#
# -u
# --suppress-output
#
# -d DISPLAY
# --display=DISPLAY
#
# --parent-id=ID
#
# -s SOCKET
# --socket-name=SOCKET
#
# -f SERVER
# --server-file=SERVER
#
# -a EDITOR
# --alternate-editor=EDITOR
#
# -T PREFIX
# --tramp=PREFIX
#

#------------------------------------------------#

# $ emacsclient --help
# 
# Usage: /nix/store/p1if8dbvw752c5n4qrxrnkyjz45q0sln-emacs-26.1/bin/emacsclient [OPTIONS] FILE...
#
# Tell the Emacs server to visit the specified files.
# Every FILE can be either just a FILENAME or [+LINE[:COLUMN]] FILENAME.
#
# The following OPTIONS are accepted:
# -V, --version		Just print version info and return
# -H, --help    		Print this usage information message
# -nw, -t, --tty 		Open a new Emacs frame on the current terminal
# -c, --create-frame    	Create a new frame instead of trying to
# 			use the current Emacs frame
# -F ALIST, --frame-parameters=ALIST
# 			Set the parameters of a new frame
# -e, --eval    		Evaluate the FILE arguments as ELisp expressions
# -n, --no-wait		Don't wait for the server to return
# -q, --quiet		Don't display messages on success
# -u, --suppress-output   Don't display return values from the server
# -d DISPLAY, --display=DISPLAY
# 			Visit the file in the given display
# --parent-id=ID          Open in parent window ID, via XEmbed
# -s SOCKET, --socket-name=SOCKET
# 			Set filename of the UNIX socket for communication
# -f SERVER, --server-file=SERVER
# 			Set filename of the TCP authentication file
# -a EDITOR, --alternate-editor=EDITOR
# 			Editor to fallback to if the server is not running
# 			If EDITOR is the empty string, start Emacs in daemon
# 			mode and try connecting again
# -T PREFIX, --tramp=PREFIX
#                         PREFIX to prepend to filenames sent by emacsclient
#                         for locating files remotely via Tramp
#
# Report bugs with M-x report-emacs-bug.
#

##################################################
# Dependencies:

command -v emacsclient  >/dev/null
command -v grep         >/dev/null
command -v sed          >/dev/null

##################################################
# Code:

# shellcheck disable=SC2207
_emacsclient_completions ()
{

    #--------------------------#

    local Subcommands
    Subcommands=( )

    # ^ « emacsclient »'s subcommands.

    #--------------------------#

    local Options
    Options=( "-V" "--version" "-H" "--help" "-nw" "-t" "--tty" "-c" "--create-frame" "-F" "--frame-parameters" "-e" "--eval" "-n" "--no-wait" "-q" "--quiet" "-u" "--suppress-output" "-d" "--display" "--parent" "-s" "-socket-name" "-f" "--server-file" "-a" "--alternate-editor" "-T" "--tramp" )

    # ^ « emacsclient »'s options and flags.

    #--------------------------#

    local UnaryOptions
    UnaryOptions=( "-F" "--frame-parameters" "-e" "--eval" "-d" "--display" "--parent" "-s" "-socket-name" "-f" "--server-file" "-a" "--alternate-editor" "-T" "--tramp" )

    # ^ « emacsclient »'s (non-flag) options.

    #--------------------------#

    local CurrentWord
    CurrentWord="${COMP_WORDS[$COMP_CWORD]}"

    # ^ the word currently being completed

    local PreviousWord
    if [ "$COMP_CWORD" -ge 1 ]
    then
        PreviousWord="${COMP_WORDS[COMP_CWORD-1]}"
    else
        PreviousWord=""
    fi

    # ^ the word to the left of the current word.
    #
    #   e.g. in « emacsclient -v -f ./<TAB> »:
    #
    #       PreviousWord="-f"
    #       CurrentWord="./"

    #--------------------------#

    COMPREPLY=( )

   # COMPREPLY+=( $( compgen -A file -- "$CurrentWord") )

    case "$PreviousWord" in

        "-f"|"--server-file")

            COMPREPLY+=( $( compgen -A file -- "$CurrentWord") )

            # e.g. SERVER_FILE: « /tmp/emacs1001/server29946 »
            #
            # e.g.
            #      $ echo "$UID"
            #      1001
            #

            ;;

        "-a"|"--alternate-editor")

            COMPREPLY+=( $( compgen -A command -- "$CurrentWord") )

            # e.g. EDITOR: « nano »
            #

            ;;

        *)

            COMPREPLY+=( $( compgen -A file -- "$CurrentWord") )
            COMPREPLY+=( $( compgen -W "${Options[*]}" -- "$CurrentWord" ) )
           #COMPREPLY+=( $( compgen -W "${Subcommands[*]}" -- "$CurrentWord" ) )

            #TODO# "FILE is FILENAME or [+LINE[:COLUMN]] FILENAME"
            
            ;;

    esac

    #--------------------------#
}

##################################################

complete -F _emacsclient_completions -o default emacsclient
