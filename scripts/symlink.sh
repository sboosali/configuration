#!/bin/bash
set -e
########################################
CONFIGURATION=/home/sboo/configuration
# ^ {{ln -s}} wants an absolute-path for the real file linked to by the symlink.
########################################
ln -sf "$CONFIGURATION/desktop/emacs.desktop" ~/.local/share/applications/emacs.desktop
########################################
# NOTES

# $ man ln
# 
# Symbolic links can hold arbitrary text; if later resolved, a relative link is interpreted in relation to its parent directory.
#
#        -r, --relative
#               create symbolic links relative to link location
# 
#        -s, --symbolic
#               make symbolic links instead of hard links
# 
# 

########################################