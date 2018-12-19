##################################################
# Settings...

.EXPORT_ALL_VARIABLES:

SHELL=bash

##################################################
# Programs...

# TEX ?=xelatex -file-line-error -interaction=nonstopmode

OPEN ?=xdg-open

NIX_SHELL ?=nix-shell

##################################################
# Files...

Directory ?=./archive

##################################################
# Targets...

default: build open

.PHONY: default

#------------------------------------------------#

build:
	time $(NIX_SHELL) ./shell.nix --run './build.sh'

.PHONY: build

#------------------------------------------------#

check:
	$(NIX_SHELL) ./shell.nix --run 'chktex *.tex'
#TODO	$(NIX_SHELL) ./shell.nix --run 'chktex *.cls'

.PHONY: check

#------------------------------------------------#

open: build
	$(OPEN) *.pdf

.PHONY: open

#------------------------------------------------#

install: build
	@mkdir -p $(Directory)/
	@mv ./*.pdf $(Directory)/

# install: build
# 	@mkdir -p $(Directory)/
# 	@cp -v ./result/*.pdf $(Directory)/
# 	@ls -l $(Directory)/

.PHONY: install

#------------------------------------------------#

fetch:
	nix-prefetch-url --unpack 'https://github.com/NixOS/nixpkgs/archive/18.09.tar.gz' 2>/dev/null

.PHONY: fetch

#------------------------------------------------#

clean:
	@rm -f *.{aux,log,out}
	@rm -f result || rm -f ./result/

.PHONY: clean

##################################################