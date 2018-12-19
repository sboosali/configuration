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

CP ?=cp "--no-preserve=mode,ownership"

NIX ?="nix"

NIX_EVAL ?=nix-instantiate --eval

NIX_BUILD ?=nix-build --show-trace

NIX_REPL ?=$(NIX) repl

##################################################

# Files...

#TODO ResumeTex ?=./tex/resume.tex

OutputDirectory ?=.make/

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
	$(NIX_REPL) ./nix/resume/

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
	rm -f result/		                 # « ./result » is a symlink.
	rm -f $(OutputDirectory)                 # « ./.make » is our working directory.

.PHONY: clean

##################################################

resume.tex: #TODO « ./nix/**/*.nix »
#TODO	nix eval ./nix -A 'resume' > ./tex/resume.tex
	$(NIX_EVAL) --strict --expr '(import nix/resume {}).resume'

##################################################