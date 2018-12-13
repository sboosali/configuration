##################################################
# Makefile Directives
##################################################

.EXPORT_ALL_VARIABLES:

##################################################
# Makefile Settings
##################################################

SHELL=bash

##################################################
# Targets
##################################################

default: build open

.PHONY: default

#------------------------------------------------#

build:
	nix-shell --run 'xelatex -file-line-error -interaction=nonstopmode resume.tex'

	find -L ./result

.PHONY: build

#------------------------------------------------#

open: build
	xdg-open result/resume.pdf

.PHONY: open

#------------------------------------------------#

install: build
	mkdir -p archive/
	cp "--no-preserve=mode,ownership" "result/resume.pdf" "archive/resume.pdf"

	ls -l ./archive

.PHONY: open

#------------------------------------------------#

clean:
	rm -f *.{aux,log,out}	                 # TeX temp files.
	rm result/		                 # « ./result » is a symlink.

.PHONY: clean

##################################################