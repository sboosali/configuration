##################################################
# Makefile Directives
##################################################

.EXPORT_ALL_VARIABLES:

SHELL=bash

##################################################
# Makefile Settings
##################################################

# Programs...

Latex ?=xelatex -file-line-error -interaction=nonstopmode

Open ?=xdg-open

##################################################

# Files...

Basename ?=resume

InstallationDirectory ?=../archive

##################################################
# Targets
##################################################

default: build open

.PHONY: default

#------------------------------------------------#

clean:
	rm -f *.{aux,log,out}	                 # TeX temp files.
	rm -f *.{dvi,pdf}			 # TeX output files.

.PHONY: clean

##################################################

build:
	$(Latex) "$(Basename).tex"

.PHONY: build

#------------------------------------------------#

open: build

	$(Open) "$(Basename).pdf"

.PHONY: open

#------------------------------------------------#

install: build

	mkdir -p "$(InstallationDirectory)/"
	cp "--no-preserve=mode,ownership" "$(Basename).pdf" "$(InstallationDirectory)/$(Basename).pdf"

	@echo
	@ls -l "$(InstallationDirectory)/"

.PHONY: open

##################################################