##################################################
# Makefile Settings ##############################
##################################################

SHELL=bash

.EXPORT_ALL_VARIABLES:

##################################################
# Makefile Variables #############################
##################################################

Timestamp ?=$(shell date +%d-%m-%Y+%H:%M)

#------------------------------------------------#

HM_FILE    ?=${HOME}/configuration/home-manager/nix/home.nix

#------------------------------------------------#

EmacsDirectory ?=${HOME}/.emacs.d

EmacsSubDirectory ?=$(EmacsDirectory)/sboo

#------------------------------------------------#

HM ?=home-manager

#HM_FILE    ?=${HOME}/configuration/home-manager/nix/home.nix
#HM_FILE    ?=./configuration/home-manager/nix/home.nix

HM_NIXPKGS ?=

# HM_NIXPKGS ?=<nixpkgs>
# HM_NIXPKGS ?=${HOME}/.nix-defexpr/channels/nixos-18.09
# HM_NIXPKGS ?=https://nixos.org/channels/nixos-18.09

#------------------------------------------------#

NIX_OPTIONS ?=--show-trace

#------------------------------------------------#

Nix      ?=nix
NixBuild ?=nix-build --show-trace
NixShell ?=nix-shell --show-trace

#------------------------------------------------#

Emacs ?=emacs

EmacsBuild ?=emacs -batch  --funcall=batch-byte-compile  --directory=$(EmacsSubDirectory)

EmacsOptions ?=--name=SBoo/$(Timestamp) --no-desktop --maximized --no-splash

#EmacsOptions ?= --maximized --no-splash --name=SBoo/$(Timestamp) --debug-init --no-desktop

#------------------------------------------------#

##################################################
# Makefile Targets ###############################
##################################################

default: build

.PHONY: default

#------------------------------------------------#

configure: bootstrap

# ^ not « .PHONY », writes the « .gitignore »'d « ./configure » script.

#------------------------------------------------#

build: home-manager

.PHONY: build

#------------------------------------------------#

check: build

.PHONY: check

#================================================#
# Home Manager ==================================#
#================================================#

bootstrap:



.PHONY: bootstrap

#------------------------------------------------#

home-manager:

	$(HM) -f $(HM_FILE) build


#	                               $(HM) -f $(HM_FILE) build
#	NIX_PATH=nixpkgs=$(HM_NIXPKGS) $(HM) -f $(HM_FILE) build

.PHONY: home-manager

#------------------------------------------------#

switch: build

	$(HM) -f $(HM_FILE) switch

.PHONY: switch

#------------------------------------------------#

build-home:

	$(NixBuild) $(HM_FILE) --out-link "./result-home"

.PHONY: build-home

# ^ build « home.nix » with « nix-build --show-trace »
#   (not with « home-manager build »).

#------------------------------------------------#

#================================================#
# Emacs =========================================#
#================================================#

# emacs:
# .PHONY: emacs

#------------------------------------------------#

emacs-run: build  #TODO# emacs-build

	exec $(Emacs) $(EmacsOptions) &disown

.PHONY: emacs-run

#------------------------------------------------#

emacs-debug: build  #TODO# emacs-build

	$(Emacs) $(EmacsOptions) --debug-init

.PHONY: emacs-debug

#------------------------------------------------#

emacs-build: #TODO

	$(EmacsBuild) $(EmacsSubDirectory)/*.el

.PHONY: emacs-build

#------------------------------------------------#

emacs-clean:

	find "$(EmacsSubDirectory)" -type f -name '*.elc' -print
	find "$(EmacsSubDirectory)" -type f -name '*.elc' -delete

.PHONY: emacs-clean

#================================================#
# Installation ==================================#
#================================================#

# installing/configuring dependencies.

#------------------------------------------------#

apt-install:

        #----------------------#

	sudo apt update

        #----------------------#

	sudo apt install -y "virtualbox-5.1"
	sudo apt install -y "virtualbox-guest-additions-iso"
	sudo apt install -y "virtualbox-ext-pack"

	sudo apt install -y "exfat-utils"

	sudo apt install -y "freeglut3-dev"

	sudo apt install -y "portaudio19-dev"

	sudo apt install -y "lightdm"
	sudo apt install -y "xubuntu-desktop"

	sudo apt install -y "paper-icon-theme"

#	sudo apt install -y ""

        #----------------------#

	sudo apt install -y "locales"
	sudo apt install -y "language-pack-en"

	sudo locale-gen en_US.UTF-8
	sudo dpkg-reconfigure locales

        #----------------------#

	sudo ln -s $(HOME)/.nix-profile/bin/emacs /usr/bin/emacs

        #----------------------#

.PHONY: apt-install

#------------------------------------------------#

manual-install:

        #----------------------#

	wget "https://ftp.gnu.org/gnu/bash/bash-3.2.tar.gz"
	tar -xv  -f bash-3.2.tar.gz  bash-3.2
	cd ./bash-3.2
	(./configure  &&  make bash)

        #----------------------#

.PHONY: manual-install

#------------------------------------------------#

# nix-install:

# 	nix-env --install ""
# 	nix-env --install ""
# 	nix-env --install ""

# .PHONY: nix-install

#------------------------------------------------#

##################################################
# Notes ##########################################
##################################################

#------------------------------------------------#
# « apt »:

# virtualbox				/xenial-updates,xenial-security,now 5.1.38-dfsg-0ubuntu1.16.04.2 amd64
# virtualbox-ext-pack			/xenial-updates,xenial-updates,now 5.1.38-0ubuntu1.16.04.1 all
# virtualbox-guest-additions-iso	/xenial-updates,xenial-updates,now 5.1.38-0ubuntu1.16.04.1 all

#------------------------------------------------#



#------------------------------------------------#
##################################################
