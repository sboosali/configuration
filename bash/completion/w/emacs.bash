#!/bin/env bash

##################################################

# « emacs » command-line completion
#
# GPL-3.0-or-later © 2019 "Sam Boosalis" <samboosalis@gmail.com>

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
# Code:

_emacs_options=( )

_emacs_options+=(        "--help"                               )
_emacs_options+=(        "--version"                            )
_emacs_options+=(        "--batch"                              )
_emacs_options+=(        "--chdir"                              )
_emacs_options+=(        "--daemon"               "--bg-daemon" )
_emacs_options+=(        "--fg-daemon"                          )
_emacs_options+=(        "--debug-init"                         )
_emacs_options+=( "-d"   "--display"                            )
_emacs_options+=(        "--module-assertions"                  )
_emacs_options+=(        "--no-build-details"                   )
_emacs_options+=(        "--no-desktop"                         )
_emacs_options+=( "-q"   "--no-init-file"                       )
_emacs_options+=( "-nl"  "--no-loadup"                          )
_emacs_options+=(        "--no-site-file"                       )
_emacs_options+=(        "--no-x-resources"                     )
_emacs_options+=( "-nsl" "--no-site-lisp"                       )
_emacs_options+=(        "--no-splash"                          )
_emacs_options+=( "-nw"  "--no-window-system"                   )
_emacs_options+=( "-Q"   "--quick"                              )
_emacs_options+=(        "--script"                             )
_emacs_options+=( "-t"   "--terminal"                           )
_emacs_options+=( "-u"   "--user"                               )
_emacs_options+=( "-L"   "--directory"                          )
_emacs_options+=(        "--eval"                               )
_emacs_options+=(        "--execute"                            )
_emacs_options+=(        "--file"                               )
_emacs_options+=(        "--find-file"                          )
_emacs_options+=( "-f"   "--funcall"                            )
_emacs_options+=(        "--insert"                             )
_emacs_options+=(        "--kill"                               )
_emacs_options+=( "-l"   "--load"                               )
_emacs_options+=(        "--visit"                              )
_emacs_options+=( "-bg"  "--background-color"                   )
_emacs_options+=( "-D"   "--basic-display"                      )
_emacs_options+=( "-bd"  "--border-color"                       )
_emacs_options+=( "-bw"  "--border-width"                       )
_emacs_options+=(        "--color"                              )
_emacs_options+=( "-cr"  "--cursor-color"                       )
_emacs_options+=( "-fn"  "--font"                               )
_emacs_options+=( "-fg"  "--foreground-color"                   )
_emacs_options+=( "-fh"  "--fullheight"                         )
_emacs_options+=( "-fs"  "--fullscreen"                         )
_emacs_options+=( "-fw"  "--fullwidth"                          )
_emacs_options+=( "-mm"  "--maximized"                          )
_emacs_options+=( "-g"   "--geometry"                           )
_emacs_options+=( "-nbi" "--no-bitmap-icon"                     )
_emacs_options+=(        "--iconic"                             )
_emacs_options+=( "-ib"  "--internal-border"                    )
_emacs_options+=( "-lsp" "--line-spacing"                       )
_emacs_options+=( "-ms"  "--mouse-color"                        )
_emacs_options+=(        "--name"                               )
_emacs_options+=( "-nbc" "--no-blinking-cursor"                 )
_emacs_options+=( "-r"   "--reverse-video"        "-rv"         )
_emacs_options+=( "-T"   "--title"                              )
_emacs_options+=( "-vb"  "--vertical-scroll-bars"               )
_emacs_options+=(        "--xrm"                                )
_emacs_options+=(        "--parent-id"                          )

#------------------------------------------------#

complete -W "${_emacs_options[*]}" emacs
