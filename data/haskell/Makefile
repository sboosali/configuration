#------------------------------------------------#
# Makefile Settings -----------------------------#
#------------------------------------------------#

SHELL=bash

.EXPORT_ALL_VARIABLES:

#------------------------------------------------#
# Makefile Variables ----------------------------#
#------------------------------------------------#
# Components...

CabalTargets ?=all
CabalTarget  ?=mtg-json:lib:mtg-json
CabalProgram ?=mtg-json:exe:mtg-json

#------------------------------------------------#
# Programs...

Cabal ?=cabal
Ghc   ?=ghc

#------------------------------------------------#
# Paths...

DataDirectory ?=./data

#------------------------------------------------#
# Environment Variables...

LC_ALL=C.UTF-8

#------------------------------------------------#
# Makefile Targets: Standard --------------------#
#------------------------------------------------#

build:
	@printf "\n%s\n" "========================================"

	@printf "%s\n\n" "Building..."

	$(Cabal) new-build $(CabalOptions) $(CabalTargets)

	@printf "\n%s\n" "========================================"

.PHONY: build

#------------------------------------------------#

check:
	@printf "\n%s\n" "========================================"

	@printf "%s\n\n" "Testing..."

	$(Cabal) new-test $(CabalOptions) --enable-tests $(CabalTargets)

	@printf "\n%s\n" "========================================"

.PHONY: check

#------------------------------------------------#

install:
	@printf "\n%s\n" "========================================"

	@printf "%s\n\n" "Installing..."

	$(Cabal) new-install $(CabalOptions) $(CabalProgram)

	@printf "\n%s\n" "========================================"

.PHONY: install

#------------------------------------------------#

dist:
	@printf "\n%s\n" "========================================"

	@printf "%s\n\n" "Archiving..."

	$(Cabal) new-sdist $(CabalOptions) $(CabalTargets)

	@printf "\n%s\n" "========================================"

.PHONY: dist

#------------------------------------------------#

all: build check install dist

.PHONY: all

#------------------------------------------------#

clean:

	rm -rf dist/ dist-newstyle/ .sboo/
	rm -f *.project.local .ghc.environment.*

	rm -rf "result/" result-*/
	find .  -type f  -name 'TAGS'  -exec  rm -f '{}'  \+

#	rm -fr _
#	killall _

.PHONY: clean

#------------------------------------------------#
# Makefile Targets: Custom ----------------------#
#------------------------------------------------#
# ...



#------------------------------------------------#
# Cabal...

docs:

	$(Cabal) new-haddock $(CabalTargets)

.PHONY: docs

#------------------------------------------------#

update:

	cabal new-update $(HaskellRepository)

.PHONY: update

#------------------------------------------------#
# Miscellaneous...



#------------------------------------------------#
# EOF -------------------------------------------#
#------------------------------------------------#