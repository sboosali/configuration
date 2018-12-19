##################################################
# Makefile Directives
##################################################

.EXPORT_ALL_VARIABLES:

SHELL=bash

##################################################
# Makefile Settings
##################################################

# Programs...

TEX ?=xelatex -file-line-error -interaction=nonstopmode

OPEN ?=xdg-open

CP ?=cp "--no-preserve=mode,ownership"

RM ?=rm

NIX ?="nix"

NIX_EVAL ?=nix-instantiate --eval

NIX_BUILD ?=nix-build --show-trace

NIX_REPL ?=$(NIX) repl

##################################################

# Files...

#TODO ResumeTex ?=./tex/resume.tex

OutputDirectory ?=./.make

ResultDirectory ?=./result

ArchiveDirectory ?=./archive

NixDirectory ?=./nix

##################################################
# Targets
##################################################

default: build open

.PHONY: default

#------------------------------------------------#

build:

.PHONY: build

#------------------------------------------------#

all: json cls tex pdf

.PHONY: all

##################################################

resume:
	@$(NIX_BUILD) $(NixDirectory) -A 'resume'

.PHONY: resume

#------------------------------------------------#

pdf:
	@mkdir -p "$(OutputDirectory)"
	@$(CP) `$(NIX_BUILD) $(NixDirectory) -A 'resume.pdf'` "$(OutputDirectory)/resume.pdf"

.PHONY: pdf

#------------------------------------------------#

tex:
	@mkdir -p "$(OutputDirectory)"
	@$(CP) `$(NIX_BUILD) $(NixDirectory) -A 'resume.tex'` "$(OutputDirectory)/resume.tex"

.PHONY: tex

#------------------------------------------------#

cls:
	@mkdir -p "$(OutputDirectory)"
	@$(CP) `$(NIX_BUILD) $(NixDirectory) -A 'resume.cls'` "$(OutputDirectory)/resume.cls"

.PHONY: cls

#------------------------------------------------#

json:
	@mkdir -p "$(OutputDirectory)"
	@$(CP) `$(NIX_BUILD) $(NixDirectory) -A 'resume.json'` "$(OutputDirectory)/resume.json"

.PHONY: json

#------------------------------------------------#

repl:
	@$(NIX_REPL) "$(NixDirectory)/repl.nix"

#------------------------------------------------#

open: build
	$(OPEN) $(ResultDirectory)/resume.pdf

.PHONY: open

#------------------------------------------------#

install:
	mkdir -p $(ArchiveDirectory)
	$(CP) -v $(OutputDirectory)/* $(ArchiveDirectory)
	ls -l $(ArchiveDirectory)

.PHONY: install

#------------------------------------------------#

clean:
	@$(RM) -f *.{aux,log,out}
	@$(RM) $(ResultDirectory) || rm -f $(ResultDirectory)/
	@$(RM) -fr $(OutputDirectory)

# ^ NOTE:
# 1. TeX generates several temporary-files.
# 2. « ./result » is a symlink.
# 3. « ./.make » is our working directory.

# ^ NOTE « ./result » may be either a file or a directory.

.PHONY: clean

##################################################