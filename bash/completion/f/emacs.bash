#!/bin/env bash

##################################################

# « emacs » command-line completion
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
#     * run:    « shellcheck ./share/bash-completion/completions/emacs »
#
# (2) Interpret via Bash 3
#
#     * run:    « bash --noprofile --norc ./share/bash-completion/completions/emacs »
#

##################################################
# Notes:

# $ emacs --help 
# Usage: /nix/store/z6x936aa6kfnwpz8fb34z28qng5prrp9-emacs-26.1/bin/emacs [OPTION-OR-FILENAME]...
# 
# Run Emacs, the extensible, customizable, self-documenting real-time
# display editor.  The recommended way to start Emacs for normal editing
# is with no options at all.
# 
# Run M-x info RET m emacs RET m emacs invocation RET inside Emacs to
# read the main documentation for these command-line arguments.
# 
# Initialization options:
# 
# --batch                     do not do interactive display; implies -q
# --chdir DIR                 change to directory DIR
# --daemon, --bg-daemon[=NAME] start a (named) server in the background
# --fg-daemon[=NAME]          start a (named) server in the foreground
# --debug-init                enable Emacs Lisp debugger for init file
# --display, -d DISPLAY       use X server DISPLAY
# --module-assertions         assert behavior of dynamic modules
# --no-build-details          do not add build details such as time stamps
# --no-desktop                do not load a saved desktop
# --no-init-file, -q          load neither ~/.emacs nor default.el
# --no-loadup, -nl            do not load loadup.el into bare Emacs
# --no-site-file              do not load site-start.el
# --no-x-resources            do not load X resources
# --no-site-lisp, -nsl        do not add site-lisp directories to load-path
# --no-splash                 do not display a splash screen on startup
# --no-window-system, -nw     do not communicate with X, ignoring $DISPLAY
# --quick, -Q                 equivalent to:
#                               -q --no-site-file --no-site-lisp --no-splash
#                               --no-x-resources
# --script FILE               run FILE as an Emacs Lisp script
# --terminal, -t DEVICE       use DEVICE for terminal I/O
# --user, -u USER             load ~USER/.emacs instead of your own
# 
# Action options:
# 
# FILE                    visit FILE
# +LINE                   go to line LINE in next FILE
# +LINE:COLUMN            go to line LINE, column COLUMN, in next FILE
# --directory, -L DIR     prepend DIR to load-path (with :DIR, append DIR)
# --eval EXPR             evaluate Emacs Lisp expression EXPR
# --execute EXPR          evaluate Emacs Lisp expression EXPR
# --file FILE             visit FILE
# --find-file FILE        visit FILE
# --funcall, -f FUNC      call Emacs Lisp function FUNC with no arguments
# --insert FILE           insert contents of FILE into current buffer
# --kill                  exit without asking for confirmation
# --load, -l FILE         load Emacs Lisp FILE using the load function
# --visit FILE            visit FILE
# 
# Display options:
# 
# --background-color, -bg COLOR   window background color
# --basic-display, -D             disable many display features;
#                                   used for debugging Emacs
# --border-color, -bd COLOR       main border color
# --border-width, -bw WIDTH       width of main border
# --color, --color=MODE           override color mode for character terminals;
#                                   MODE defaults to `auto', and
#                                   can also be `never', `always',
#                                   or a mode name like `ansi8'
# --cursor-color, -cr COLOR       color of the Emacs cursor indicating point
# --font, -fn FONT                default font; must be fixed-width
# --foreground-color, -fg COLOR   window foreground color
# --fullheight, -fh               make the first frame high as the screen
# --fullscreen, -fs               make the first frame fullscreen
# --fullwidth, -fw                make the first frame wide as the screen
# --maximized, -mm                make the first frame maximized
# --geometry, -g GEOMETRY         window geometry
# --no-bitmap-icon, -nbi          do not use picture of gnu for Emacs icon
# --iconic                        start Emacs in iconified state
# --internal-border, -ib WIDTH    width between text and main border
# --line-spacing, -lsp PIXELS     additional space to put between lines
# --mouse-color, -ms COLOR        mouse cursor color in Emacs window
# --name NAME                     title for initial Emacs frame
# --no-blinking-cursor, -nbc      disable blinking cursor
# --reverse-video, -r, -rv        switch foreground and background
# --title, -T TITLE               title for initial Emacs frame
# --vertical-scroll-bars, -vb     enable vertical scroll bars
# --xrm XRESOURCES                set additional X resources
# --parent-id XID                 set parent window
# --help                          display this help and exit
# --version                       output version information and exit
# 
# You can generally also specify long option names with a single -; for
# example, -batch as well as --batch.  You can use any unambiguous
# abbreviation for a --option.
# 
# Various environment variables and window system resources also affect
# the operation of Emacs.  See the main documentation.
# 

##################################################
# Dependencies:

command -v emacs  >/dev/null
command -v grep   >/dev/null
command -v sed    >/dev/null

##################################################
# Code:


# --batch                     
# --chdir DIR                 
# --daemon, --bg-daemon[=NAME]
# --fg-daemon[=NAME]          
# --debug-init                
# --display, -d DISPLAY       
# --module-assertions         
# --no-build-details          
# --no-desktop                
# --no-init-file, -q          
# --no-loadup, -nl            
# --no-site-file              
# --no-x-resources            
# --no-site-lisp, -nsl        
# --no-splash                 
# --no-window-system, -nw     
# --quick, -Q                 
# --script FILE               
# --terminal, -t DEVICE       
# --user, -u USER             
# --directory, -L DIR
# --eval EXPR        
# --execute EXPR     
# --file FILE        
# --find-file FILE   
# --funcall, -f FUNC 
# --insert FILE      
# --kill             
# --load, -l FILE    
# --visit FILE       
# --background-color, -bg COLOR
# --basic-display, -D         
# --border-color, -bd COLOR   
# --border-width, -bw WIDTH   
# --color, --color=MODE       
# --cursor-color, -cr COLOR   
# --font, -fn FONT            
# --foreground-color, -fg COLOR
# --fullheight, -fh           
# --fullscreen, -fs           
# --fullwidth, -fw            
# --maximized, -mm            
# --geometry, -g GEOMETRY     
# --no-bitmap-icon, -nbi      
# --iconic                    
# --internal-border, -ib WIDTH
# --line-spacing, -lsp PIXELS 
# --mouse-color, -ms COLOR    
# --name NAME                 
# --no-blinking-cursor, -nbc  
# --reverse-video, -r, -rv    
# --title, -T TITLE           
# --vertical-scroll-bars, -vb 
# --xrm XRESOURCES            
# --parent-id XID             
# --help                      
# --version                   

# shellcheck disable=SC2207
_emacs_completions ()
{

    #--------------------------#

    local Subcommands
    Subcommands=( )

    # ^ « emacs »'s subcommands.

    #--------------------------#

    local Options
    Options=( "-V" "--version" "-H" "--help" "-nw" "-t" "--tty" "-c" "--create-frame" "-F" "--frame-parameters" "-e" "--eval" "-n" "--no-wait" "-q" "--quiet" "-u" "--suppress-output" "-d" "--display" "--parent" "-s" "-socket-name" "-f" "--server-file" "-a" "--alternate-editor" "-T" "--tramp" )

    # ^ « emacs »'s options and flags.

    #--------------------------#

    local UnaryOptions
    UnaryOptions=( "-F" "--frame-parameters" "-e" "--eval" "-d" "--display" "--parent" "-s" "-socket-name" "-f" "--server-file" "-a" "--alternate-editor" "-T" "--tramp" )

    # ^ « emacs »'s (non-flag) options.

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
    #   e.g. in « emacs -v -f ./<TAB> »:
    #
    #       PreviousWord="-f"
    #       CurrentWord="./"

    #--------------------------#

    COMPREPLY=()

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

complete -F _emacs_completions -o default emacs
