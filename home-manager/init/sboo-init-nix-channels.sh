#!/bin/bash

##################################################

nix-channel --add https://nixos.org/channels/nixpkgs-unstable        nixpkgs-unstable

nix-channel --add https://nixos.org/channels/nixos-18.09             nixos-18.09
nix-channel --add https://nixos.org/channels/nixos-18.03             nixos-18.03

#TODO nix-channel --add "file://$HOME/nixpkgs"                             nixpkgs-local
#
# $ nix-channel --update
# error: unable to download 'file:///home/sboo/nixpkgs/nixexprs.tar.bz2': Couldn't read a file:// file (37)

#TODO nix-channel --add https://github.com/sboosali/nixpkgs.git            nixpkgs-sboosali

#TODO nix-channel --add https://github.com/reflex-frp/reflex-platform.git  nixpkgs-reflex
#
# $ nix-channel --update
# error: unable to download 'https://github.com/reflex-frp/reflex-platform/nixexprs.tar.bz2': HTTP error 404

#TODO nix-channel --add git://github.com:sboosali/nixpkgs.git                nixpkgs-sboosali
#
# $ nix-channel --add git://github.com:sboosali/nixpkgs.git                nixpkgs-sboosali
# error: invalid channel URL 'git://github.com:sboosali/nixpkgs.git'

##################################################

DefaultChannel="https://nixos.org/channels/nixos-18.09"

nix-channel --add "${DefaultChannel}" nixpkgs

##################################################

nix-channel --list

nix-channel --update

##################################################
# e.g.
#
# $ nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
# $ nix-channel --add https://nixos.org/channels/nixos-18.09      nixos-18.09
# $ nix-channel --add https://nixos.org/channels/nixos-18.03      nixos-18.03
#
# $ nix-channel --list
# nixos-18.03 https://nixos.org/channels/nixos-18.03
# nixos-18.09 https://nixos.org/channels/nixos-18.09
# nixpkgs https://nixos.org/channels/nixpkgs-unstable
#
# $ nix-channel --update
# ...

##################################################