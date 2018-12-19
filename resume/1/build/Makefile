##################################################
# Makefile Directives
##################################################

.EXPORT_ALL_VARIABLES:

SHELL=bash

##################################################
# Makefile Settings
##################################################

# Programs...

TEX ?=xelatex

#TODO TEX ?=xelatex -file-line-error -interaction=nonstopmode

##################################################

# Files...

NAME ?=./resume

##################################################
# Targets
##################################################

default: build open

.PHONY: default

#------------------------------------------------#

build:
	$(TEX) -file-line-error -interaction=nonstopmode $(NAME).tex

#TODO	$(TEX) $(NAME).tex

.PHONY: build

#------------------------------------------------#

open: build
	xdg-open $(NAME).pdf

.PHONY: open

#------------------------------------------------#

clean:
	rm -f *.{aux,log,out,dvi}	                 # TeX temp files.

.PHONY: clean

##################################################
