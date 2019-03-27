##################################################
# Makefile Settings
##################################################

SHELL=bash

.EXPORT_ALL_VARIABLES:

##################################################
# Makefile Variables #############################
##################################################

Cabal ?=cabal

#------------------------------------------------#

Nix      ?=nix
NixBuild ?=nix-build --show-trace
NixShell ?=nix-shell --show-trace

##################################################
# Building #######################################
##################################################

build:

	@echo "=================================================="
	@echo ""

	$(Cabal) new-build $(CabalOptions) $(CabalTargets)

	@echo ""
	@echo "=================================================="


.PHONY: build

##################################################
# Nix ############################################
##################################################

default.nix: $(DefaultPackageName)/*.cabal
	$(Cabal2nix) $(DefaultPackageName)/*.cabal > $@

##################################################
# Executables ####################################
##################################################

run:
	$(Cabal) new-run exe:sboo-dictation-vocabulary-haskell -- ./dictation-vocabulary.hs

.PHONY: run

##################################################
# Development: developing this package
##################################################

tags:

	hasktags --etags  --follow-symlinks ./  --output TAGS  --tags-absolute

.PHONY: tags

##################################################
# Cleaning
##################################################

clean:

	$(Cabal) new-clean

	rm -rf "./dist" "./dist-newstyle" ./dist-* ".stack-work"
	rm -rf ./*/dist/ ./*/dist-*/

	rm -f *.project.local .ghc*.environment.*
	rm -rf TAGS ./*/TAGS

.PHONY: clean

#------------------------------------------------#

cabal-clean:
	$(Cabal) new-clean

.PHONY: cabal-clean

##################################################
# Documentation ##################################
##################################################

docs:

	@echo "=================================================="
	@echo ""

	$(Cabal) new-haddock $(CabalOptions) --enable-documentation $(CabalTargets)

	@echo ""
	@echo "=================================================="
	@echo ""

	find $(BuildDirectory) -name "index.html" -print

	@echo ""
	@echo "=================================================="

.PHONY: docs

##################################################
# Release ########################################
##################################################

sdist:

	$(Cabal) new-build $(CabalTargets)
	$(Cabal) new-sdist $(CabalTargets)

#	(cd ./spiros  &&  cabal sdist)

.PHONY: sdist

#------------------------------------------------#

static:

	$(Cabal) new-build --enable-executable-static $(CabalTargets)
	$(Cabal) new-sdist $(CabalTargets)

.PHONY: static

#------------------------------------------------#

install:
	$(Cabal) new-build all --prefix=$(InstallDirectory)

.PHONY: install

##################################################