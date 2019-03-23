#!/bin/env bash

##################################################

# « home-manager » command-line completion
#
# © 2019 "Sam Boosalis" <samboosalis@gmail.com>
#
# MIT License
#

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
#     * run:    « shellcheck ./share/bash-completion/completions/home-manager »
#
# (2) Interpret via Bash 3
#
#     * run:    « bash --noprofile --norc ./share/bash-completion/completions/home-manager »
#

##################################################
# Examples:

# $ home-manager <TAB>
#
# -A
# -I
# -f
# -h
# -n
# -v
# build
# edit
# expire-generations
# generations
# help
# news
# packages
# remove-generations
# switch

# $ home-manager e<TAB>
#
# edit
# expire-generations

# $ home-manager build -A programs.e<TAB>
#
# programs.eclipse
# programs.eclipse.plugins  
# programs.emacs
# programs.emacs.overrides
# programs.emacs.package    

# $ home-manager remove-generations 20<TAB>
#
# 200
# 201
# 202
# 203

##################################################
# Notes:

# « home-manager » Subcommands:
#
#   help
#   edit
#   build
#   switch
#   generations
#   remove-generations
#   expire-generations
#   packages
#   news

# « home-manager » Options:
#
#   -f FILE
#   -A ATTRIBUTE
#   -I PATH
#   -v
#   -n
#   -h

# $ home-manager
# 
# Usage: /home/sboo/.nix-profile/bin/home-manager [OPTION] COMMAND
# 
# Options
# 
#   -f FILE      The home configuration file.
#                Default is '~/.config/nixpkgs/home.nix'.
#   -A ATTRIBUTE Optional attribute that selects a configuration
#                expression in the configuration file.
#   -I PATH      Add a path to the Nix expression search path.
#   -v           Verbose output
#   -n           Do a dry run, only prints what actions would be taken
#   -h           Print this help
# 
# Commands
# 
#   help         Print this help
# 
#   edit         Open the home configuration in $EDITOR
# 
#   build        Build configuration into result directory
# 
#   switch       Build and activate configuration
# 
#   generations  List all home environment generations
# 
#   remove-generations ID...
#       Remove indicated generations. Use 'generations' command to
#       find suitable generation numbers.
# 
#   expire-generations TIMESTAMP
#       Remove generations older than TIMESTAMP where TIMESTAMP is
#       interpreted as in the -d argument of the date tool. For
#       example "-30 days" or "2018-01-01".
# 
#   packages     List all packages installed in home-manager-path
# 
#   news         Show news entries in a pager
# 

##################################################
# Dependencies:

command -v home-manager >/dev/null
command -v grep         >/dev/null
command -v sed          >/dev/null

##################################################
# Code:

_home-manager_list_generation_identifiers ()

{

    home-manager generations  |  sed -n -e 's/^................ : id \([[:alnum:]]\+\) -> .*/\1/p'

}

# NOTES
#
# (1) the « sed -n -e 's/.../.../p' » invocation:
#
#    * the « -e '...' » option takes a Sed Script.
#    * the « -n » option only prints when « .../p » would print.
#    * the « s/xxx/yyy/ » Sed Script substitutes « yyy » whenever « xxx » is matched.
#
# (2) the « '^................ : id \([[:alnum:]]\+\) -> .*' » regular expression:
#
#    * matches « 199 », for example, in the line « 2019-03-13 15:26 : id 199 -> /nix/store/mv619y9pzgsx3kndq0q7fjfvbqqdy5k8-home-manager-generation »
#
# 

#------------------------------------------------#

_home-manager_list_nix_attributes ()

{

    echo "accounts.email.accounts"
    echo "accounts.email.accounts.private"
    echo "dconf.settings"
    echo "file"
    echo "general"
    echo "gtk"
    echo "gtk.font"
    echo "gtk.font.name"
    echo "gtk.font.package"
    echo "gtk.theme"
    echo "gtk.theme.name"
    echo "gtk.theme.package"
    echo "home.file"
    echo "home.keyboard"
    echo "home.keyboard.layout"
    echo "home.keyboard.model"
    echo "home.keyboard.options"
    echo "home.keyboard.variant"
    echo "home.language"
    echo "home.language.address"
    echo "home.language.base"
    echo "home.language.monetary"
    echo "home.language.paper"
    echo "home.language.time"
    echo "home.packages"
    echo "home.username"
    echo "lib"
    echo "manual.html"
    echo "manual.manpages"
    echo "news.display"
    echo "nixpkgs.config"
    echo "nixpkgs.overlays"
    echo "programs.afew"
    echo "programs.alot"
    echo "programs.alot.bindings"
    echo "programs.alot.bindings.bufferlist"
    echo "programs.alot.bindings.envelope"
    echo "programs.alot.bindings.global"
    echo "programs.alot.bindings.search"
    echo "programs.alot.bindings.taglist"
    echo "programs.alot.bindings.thread"
    echo "programs.alot.hooks"
    echo "programs.astroid"
    echo "programs.autorandr"
    echo "programs.autorandr.hooks"
    echo "programs.autorandr.hooks.postswitch"
    echo "programs.autorandr.hooks.predetect"
    echo "programs.autorandr.hooks.preswitch"
    echo "programs.autorandr.profiles"
    echo "programs.bash"
    echo "programs.beets"
    echo "programs.beets.settings"
    echo "programs.browserpass"
    echo "programs.browserpass.browsers"
    echo "programs.chromium"
    echo "programs.chromium.extensions"
    echo "programs.chromium.package"
    echo "programs.direnv"
    echo "programs.direnv.config"
    echo "programs.direnv.stdlib"
    echo "programs.eclipse"
    echo "programs.eclipse.plugins"
    echo "programs.emacs"
    echo "programs.emacs.overrides"
    echo "programs.emacs.package"
    echo "programs.feh"
    echo "programs.feh.keybindings"
    echo "programs.firefox"
    echo "programs.firefox.package"
    echo "programs.fish"
    echo "programs.fish.package"
    echo "programs.fzf"
    echo "programs.git"
    echo "programs.git.aliases"
    echo "programs.git.ignores"
    echo "programs.git.includes"
    echo "programs.git.lfs"
    echo "programs.git.package"
    echo "programs.git.signing"
    echo "programs.git.signing.key"
    echo "programs.go"
    echo "programs.go.package"
    echo "programs.go.packages"
    echo "programs.htop"
    echo "programs.htop.delay"
    echo "programs.htop.fields"
    echo "programs.htop.meters"
    echo "programs.htop.meters.left"
    echo "programs.htop.meters.right"
    echo "programs.info"
    echo "programs.irssi"
    echo "programs.irssi.aliases"
    echo "programs.irssi.networks"
    echo "programs.jq"
    echo "programs.jq.colors"
    echo "programs.keychain"
    echo "programs.keychain.agents"
    echo "programs.keychain.keys"
    echo "programs.keychain.package"
    echo "programs.lesspipe"
    echo "programs.man"
    echo "programs.matplotlib"
    echo "programs.matplotlib.config"
    echo "programs.mbsync"
    echo "programs.mbsync.groups"
    echo "programs.mbsync.package"
    echo "programs.mercurial"
    echo "programs.mercurial.aliases"
    echo "programs.mercurial.ignores"
    echo "programs.mercurial.package"
    echo "programs.msmtp"
    echo "programs.neovim"
    echo "programs.neovim.configure"
    echo "programs.neovim.package"
    echo "programs.newsboat"
    echo "programs.newsboat.browser"
    echo "programs.newsboat.queries"
    echo "programs.newsboat.urls"
    echo "programs.noti"
    echo "programs.noti.settings"
    echo "programs.notmuch"
    echo "programs.notmuch.new"
    echo "programs.notmuch.new.ignore"
    echo "programs.notmuch.new.tags"
    echo "programs.offlineimap"
    echo "programs.opam"
    echo "programs.opam.package"
    echo "programs.pidgin"
    echo "programs.pidgin.package"
    echo "programs.pidgin.plugins"
    echo "programs.rofi"
    echo "programs.rofi.colors"
    echo "programs.rofi.colors.rows"
    echo "programs.rofi.colors.rows.active"
    echo "programs.rofi.colors.rows.active.background"
    echo "programs.rofi.colors.rows.active.foreground"
    echo "programs.rofi.colors.rows.active.highlight"
    echo "programs.rofi.colors.rows.active.highlight.background"
    echo "programs.rofi.colors.rows.active.highlight.foreground"
    echo "programs.rofi.colors.rows.normal"
    echo "programs.rofi.colors.rows.normal.background"
    echo "programs.rofi.colors.rows.normal.foreground"
    echo "programs.rofi.colors.rows.normal.highlight"
    echo "programs.rofi.colors.rows.normal.highlight.background"
    echo "programs.rofi.colors.rows.normal.highlight.foreground"
    echo "programs.rofi.colors.rows.urgent"
    echo "programs.rofi.colors.rows.urgent.background"
    echo "programs.rofi.colors.rows.urgent.foreground"
    echo "programs.rofi.colors.rows.urgent.highlight"
    echo "programs.rofi.colors.rows.urgent.highlight.background"
    echo "programs.rofi.colors.rows.urgent.highlight.foreground"
    echo "programs.rofi.colors.window"
    echo "programs.rofi.colors.window.background"
    echo "programs.rofi.colors.window.border"
    echo "programs.rofi.colors.window.separator"
    echo "programs.rofi.cycle"
    echo "programs.rofi.font"
    echo "programs.rofi.fullscreen"
    echo "programs.rofi.lines"
    echo "programs.rofi.location"
    echo "programs.rofi.padding"
    echo "programs.rofi.scrollbar"
    echo "programs.rofi.separator"
    echo "programs.rofi.terminal"
    echo "programs.rofi.theme"
    echo "programs.rofi.width"
    echo "programs.rofi.xoffset"
    echo "programs.rofi.yoffset"
    echo "programs.ssh"
    echo "programs.ssh.compression"
    echo "programs.taskwarrior"
    echo "programs.taskwarrior.config"
    echo "programs.termite"
    echo "programs.termite.browser"
    echo "programs.termite.font"
    echo "programs.termite.fullscreen"
    echo "programs.termite.geometry"
    echo "programs.termite.scrollbar"
    echo "programs.texlive"
    echo "programs.texlive.package"
    echo "programs.tmux"
    echo "programs.tmux.package"
    echo "programs.tmux.plugins"
    echo "programs.tmux.shortcut"
    echo "programs.tmux.terminal"
    echo "programs.tmux.tmuxinator"
    echo "programs.tmux.tmuxp"
    echo "programs.urxvt"
    echo "programs.urxvt.fonts"
    echo "programs.urxvt.keybindings"
    echo "programs.urxvt.package"
    echo "programs.urxvt.scroll.bar"
    echo "programs.urxvt.scroll.bar"
    echo "programs.urxvt.scroll.bar.align"
    echo "programs.urxvt.scroll.bar.floating"
    echo "programs.urxvt.scroll.bar.position"
    echo "programs.urxvt.scroll.bar.style"
    echo "programs.urxvt.scroll.lines"
    echo "programs.urxvt.shading"
    echo "programs.urxvt.transparent"
    echo "programs.vim"
    echo "programs.vim.package"
    echo "programs.vim.plugins"
    echo "programs.vim.settings"
    echo "programs.vscode"
    echo "programs.vscode.extensions"
    echo "programs.zathura"
    echo "programs.zathura.options"
    echo "programs.zsh"
    echo "programs.zsh.history"
    echo "programs.zsh.history.extended"
    echo "programs.zsh.history.path"
    echo "programs.zsh.history.save"
    echo "programs.zsh.history.share"
    echo "programs.zsh.history.size"
    echo "programs.zsh.plugins"
    echo "qt"
    echo "services.compton"
    echo "services.compton.backend"
    echo "services.compton.blur"
    echo "services.compton.fade"
    echo "services.compton.package"
    echo "services.compton.shadow"
    echo "services.dunst"
    echo "services.dunst.settings"
    echo "services.emacs"
    echo "services.flameshot"
    echo "services.kbfs"
    echo "services.kdeconnect"
    echo "services.kdeconnect.indicator"
    echo "services.keepassx"
    echo "services.keybase"
    echo "services.mbsync"
    echo "services.mbsync.frequency"
    echo "services.mbsync.package"
    echo "services.mbsync.verbose"
    echo "services.mpd"
    echo "services.mpd.network.port"
    echo "services.parcellite"
    echo "services.pasystray"
    echo "services.polybar"
    echo "services.polybar.config"
    echo "services.polybar.package"
    echo "services.polybar.script"
    echo "services.redshift"
    echo "services.redshift.brightness.day"
    echo "services.redshift.brightness.night"
    echo "services.redshift.latitude"
    echo "services.redshift.longitude"
    echo "services.redshift.package"
    echo "services.redshift.provider"
    echo "services.redshift.temperature.day"
    echo "services.redshift.temperature.night"
    echo "services.redshift.tray"
    echo "services.stalonetray"
    echo "services.stalonetray.config"
    echo "services.stalonetray.package"
    echo "services.syncthing"
    echo "services.syncthing.tray"
    echo "services.taffybar"
    echo "services.taffybar.package"
    echo "services.udiskie"
    echo "services.udiskie.automount"
    echo "services.udiskie.notify"
    echo "services.udiskie.tray"
    echo "services.unclutter"
    echo "services.unclutter.package"
    echo "services.unclutter.threshold"
    echo "services.unclutter.timeout"
    echo "services.xscreensaver"
    echo "systemd.user.paths"
    echo "systemd.user.services"
    echo "systemd.user.sockets"
    echo "systemd.user.targets"
    echo "systemd.user.timers"
    echo "xdg"
    echo "xresources.properties"
    echo "xsession"

}

#------------------------------------------------#

# shellcheck disable=SC2207
_home-manager_completions ()
{

    #--------------------------#

    local Subcommands
    Subcommands=( "help" "edit" "build" "switch" "generations" "remove-generations" "expire-generations" "packages" "news" )

    # ^ « home-manager »'s subcommands.

    #--------------------------#

    local Options
    Options=( "-f" "-A" "-I" "-h" "-n" "-v" )

    # ^ « home-manager »'s options.

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
    #   e.g. in « home-manager -v -f ./<TAB> »:
    #
    #       PreviousWord="-f"
    #       CurrentWord="./"

    #--------------------------#

    COMPREPLY=()

    case "$PreviousWord" in

        "-f")
            
            COMPREPLY+=( $( compgen -A file -- "$CurrentWord") )
            ;;

        "-I")

            COMPREPLY+=( $( compgen -A directory -- "$CurrentWord") )
            ;;

        "-A")

            COMPREPLY+=( $( compgen -W "$(_home-manager_list_nix_attributes)" -- "$CurrentWord") )
            ;;

        "remove-generations")

            COMPREPLY+=( $( compgen -W "$(_home-manager_list_generation_identifiers)" -- "$CurrentWord" ) )
            ;;

        *)

            COMPREPLY+=( $( compgen -W "${Subcommands[*]}" -- "$CurrentWord" ) )
            COMPREPLY+=( $( compgen -W "${Options[*]}" -- "$CurrentWord" ) )
            ;;

    esac

    #--------------------------#
}

##################################################

complete -F _home-manager_completions -o default home-manager

#complete -W "help edit build switch generations remove-generations expire-generations packages news" home-manager
