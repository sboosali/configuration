#!/bin/bash
set -eu
########################################

NAME="${1:-emacs}"

FILEPATH="${NAME}".desktop

########################################

desktop-file-validate ./desktop-entry-files/"$FILEPATH"

########################################

cp ./desktop-entry-files/"$FILEPATH" "$HOME"/.local/share/applications/"$FILEPATH"

########################################

#TODO KDE: dconf read /org/gnome/shell/favorite-apps

#TODO dconf write /org/gnome/shell/favorite-apps "['google-chrome.desktop', 'emacs.desktop', 'xterm-terminal.desktop', 'libreoffice-writer.desktop', 'org.gnome.Nautilus.desktop', 'gnome-tweak-tool.desktop', 'gnome-shell-extension-prefs.desktop', 'virtualbox.desktop']"

########################################
#NOTES
# `ln -sf` versus `cp`

########################################