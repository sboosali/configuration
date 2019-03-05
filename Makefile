##################################################
# Makefile Settings ##############################
##################################################

SHELL=bash

.EXPORT_ALL_VARIABLES:

##################################################
# Makefile Variables #############################
##################################################

HM ?=home-manager

HM_FILE    ?=${HOME}/configuration/home-manager/nix/home.nix

#HM_FILE    ?=${HOME}/configuration/home-manager/nix/home.nix
#HM_FILE    ?=./configuration/home-manager/nix/home.nix

HM_NIXPKGS ?=

# HM_NIXPKGS ?=<nixpkgs>
# HM_NIXPKGS ?=${HOME}/.nix-defexpr/channels/nixos-18.09
# HM_NIXPKGS ?=https://nixos.org/channels/nixos-18.09

#------------------------------------------------#

NIX_OPTIONS ?=--show-trace

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

#------------------------------------------------#

check: build

.PHONY: check

##################################################
#------------------------------------------------#

bootstrap:



.PHONY: bootstrap

#------------------------------------------------#

home-manager:

	$(HM) -f $(HM_FILE) build $(NIX_OPTIONS)

#	                               $(HM) -f $(HM_FILE) build
#	NIX_PATH=nixpkgs=$(HM_NIXPKGS) $(HM) -f $(HM_FILE) build

.PHONY: home-manager

#------------------------------------------------#

switch: build

	NIX_PATH=nixpkgs=$(HM_NIXPKGS) $(HM) -f $(HM_FILE) switch

.PHONY: switch

#------------------------------------------------#



#------------------------------------------------#
##################################################
# Installation ###################################
##################################################

# installing/configuring dependencies.

#------------------------------------------------#

apt-install:

	sudo apt update

	sudo apt install -y "virtualbox-5.1"
	sudo apt install -y "virtualbox-guest-additions-iso"
	sudo apt install -y "virtualbox-ext-pack"

	sudo apt install -y "exfat-utils"

	sudo apt install -y "freeglut3-dev"

	sudo apt install -y "portaudio19-dev"

	sudo apt install -y "lightdm"
	sudo apt install -y "xubuntu-desktop"

	sudo apt install -y "paper-icon-theme"

	sudo apt install -y "locales"
	sudo apt install -y "language-pack-en"

	sudo locale-gen en_US.UTF-8
	sudo dpkg-reconfigure locales

#	sudo apt install -y ""

.PHONY: apt-install

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