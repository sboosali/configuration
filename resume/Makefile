##################################################
# Makefile Directives
##################################################

.EXPORT_ALL_VARIABLES:

SHELL=bash

##################################################
# Makefile Settings
##################################################

# Programs...

TEX ?="xelatex -file-line-error -interaction=nonstopmode"

NIX ?="nix"

NIX_EVAL ?="nix-instantiate --eval"

NIX_REPL ?=$(NIX) repl

##################################################

# Files...

RESUME ?=./tex/resume.tex

##################################################
# Targets
##################################################

default: build open

.PHONY: default

#------------------------------------------------#

build:


.PHONY: build

#------------------------------------------------#

pdf:
	nix-shell --run '$(TEX) resume.tex'
	find -L ./result -type f -name '*.pdf'

.PHONY: pdf

#------------------------------------------------#

tex:
	die TODO

.PHONY: tex

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
	rm result/		                 # « ./result » is a symlink.

.PHONY: clean

##################################################

resume.tex: #TODO « ./nix/**/*.nix »
#TODO	nix eval ./nix -A 'resume' > ./tex/resume.tex
	$(NIX_EVAL) --strict --expr '(import nix/resume {}).resume'

##################################################