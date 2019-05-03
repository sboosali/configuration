#------------------------------------------------#
# README ----------------------------------------#
#------------------------------------------------#

# Targets:
#
# • Standard targets — « make {build,check,dist,install} ».
# • Release targets  — « make {upload,publish}-{melpa,github} ».
#

#------------------------------------------------#
# Makefile Settings -----------------------------#
#------------------------------------------------#

SHELL=bash

.EXPORT_ALL_VARIABLES:

#------------------------------------------------#
# Makefile Variables: Metadata ------------------#
#------------------------------------------------#

Version=0.0.0
Feature=expresso-mode

#------------------------------------------------#

CaskFile?=./Cask

#------------------------------------------------#
# Makefile Variables: Paths ---------------------#
#------------------------------------------------#

BuildDirectory ?=./.cask
DataDirectory  ?=./data
ShareDirectory ?=./gitignored/share

#------------------------------------------------#

#------------------------------------------------#
# Makefile Variables: Options -------------------#
#------------------------------------------------#

EmacsOptions ?=--no-init-file --maximized --no-splash --no-desktop

#------------------------------------------------#
# Makefile Variables: Programs ------------------#
#------------------------------------------------#

Cask?=cask

#------------------------------------------------#

Emacs      ?=emacs
EmacsBuild ?=emacs  -batch  --funcall=batch-byte-compile
EmacsStart ?=emacs "--name=Emacs - SBoo/$(Timestamp)" --maximized --no-splash --no-desktop

#------------------------------------------------#

Open ?=xdg-open
Nix  ?=nix

#------------------------------------------------#
# Makefile Variables: Paths ---------------------#
#------------------------------------------------#

BuildDirectory   ?=./dist-newstyle
DataDirectory    ?=./data

#------------------------------------------------#

ShareDirectory      ?=./gitignored/share
HaddockDirectory    ?=$(ShareDirectory)/doc
CompletionDirectory ?=$(ShareDirectory)/bash/completions

#------------------------------------------------#
# Makefile Variables: Options -------------------#
#------------------------------------------------#

CaskOptions=--cask-file $(ProjectFile) --builddir $(BuildDirectory)

#------------------------------------------------#

MelpaUser     =sboo
MelpaPassword =pass melpa.org/user/$(MelpaUser)

#------------------------------------------------#

GitHubOwner      =sboosali
GitHubRepository =$(Project)

#------------------------------------------------#
# Makefile Variables: Subcommands ---------------#
#------------------------------------------------#

CaskBuild   ?=$(Cask) new-build $(CaskOptions)
CaskRun     ?=$(Cask) new-run $(CaskOptions)
CaskInstall ?=$(Cask) -v --overwrite-policy=always new-install
CaskTest    ?=$(Cask) new-test --enable-tests $(CaskOptions)
CaskBench   ?=$(Cask) new-bench --enable-benchmarks $(CaskOptions)
CaskDocs    ?=$(Cask) new-haddock --enable-documentation $(CaskOptions)

#------------------------------------------------#
# Makefile Variables: Environment Variables -----#
#------------------------------------------------#

LC_ALL=C.UTF-8

#------------------------------------------------#
# Makefile Targets: Standard --------------------#
#------------------------------------------------#

# Emacs

build:

	$(EmacsBuild)  $(EmacsDirectory)/sboo/*.el

.PHONY: build

#------------------------------------------------#

rebuild: clean

	$(EmacsBuild)  $(EmacsDirectory)/sboo/*.el

.PHONY: rebuild

#================================================#

start: build

	exec $(EmacsStart) &disown

.PHONY: start

#------------------------------------------------#

emacs-run:

	exec $(EmacsStart) &disown

.PHONY: emacs-run

#------------------------------------------------#

emacs-try:

	SBOO_EMACS_DESKTOP_RESTORE_EAGER=10 SBOO_EMACS_DESKTOP_WRITE=0 $(Emacs) $(EmacsOptions) --debug-init

.PHONY: emacs-try

#------------------------------------------------#

emacs-terminal:

	SBOO_EMACS_DESKTOP_RESTORE_EAGER=10 SBOO_EMACS_DESKTOP_WRITE=0 $(Emacs) $(EmacsOptions) --no-window-system --debug-init

.PHONY: emacs-terminal

#------------------------------------------------#

emacs-debug:

	SBOO_EMACS_DESKTOP_ENABLE=0 $(Emacs) $(EmacsOptions) --debug-init "--find-file=$(EmacsDirectory)/sboo/sboo-init.el"

.PHONY: emacs-debug

#================================================#

emacs-build: build
.PHONY: emacs-build

#------------------------------------------------#

# emacs-test: build

# 	SBOO_EMACS_DESKTOP_RESTORE_EAGER=10 $(Emacs) $(EmacsOptions) --debug-init

# .PHONY: emacs-test

#------------------------------------------------#
# Nix -------------------------------------------#
#------------------------------------------------#

configure:

	@exec nix-build

.PHONY: configure

#------------------------------------------------#
# Cask ------------------------------------------#
#------------------------------------------------#

cask-build:
	$(Cask) build

.PHONY: cask-build

##################################################
# Emacs: Run / Test. #############################
##################################################

run: configure
	@exec $(Emacs) $(EmacsOptions)

.PHONY: run

##################################################

test: configure
	@exec $(Emacs) $(EmacsOptions)

.PHONY: test

##################################################

exec:
	~/.nix-profile/bin/emacs --name=Emacs/SBoo/Nixpkgs/$(Timestamp) --maximized --no-splash &disown

.PHONY: exec

##################################################

clean:
	find $(EmacsDirectory)/sboo $(EmacsDirectory)/lisp  -type f  -name '*.elc'  -delete

.PHONY: clean

##################################################