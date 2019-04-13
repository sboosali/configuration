#------------------------------------------------#
# README ----------------------------------------#
#------------------------------------------------#

# Targets:
#
# • Standard targets — « make {build,check,dist,install} ».
# • Release targets  — « make static », « make release », « make {upload,publish}-{hackage,github} ».
#

#------------------------------------------------#
# Makefile Settings -----------------------------#
#------------------------------------------------#

SHELL=bash

.EXPORT_ALL_VARIABLES:

#------------------------------------------------#
# Makefile Variables ----------------------------#
#------------------------------------------------#
# Metadata...

Version=0.0.0

Project ?=TODO
Package ?=TODO
Program ?=$(Package)

#------------------------------------------------#
# Components...

CabalTargets ?=all
CabalTarget  ?=lib:$(Package)
CabalProgram ?=exe:$(Program)

#------------------------------------------------#

CabalProject ?=./cabal.project

#------------------------------------------------#
# Makefile Variables ----------------------------#
#------------------------------------------------#
# Programs...

Cabal ?=cabal
Ghc   ?=ghc
Open  ?=xdg-open

#------------------------------------------------#
# Paths...

DataDirectory  ?=./data
BuildDirectory ?=./dist-newstyle

#------------------------------------------------#
# Options...

CabalOptions=--project-file $(ProjectFile) --builddir $(BuildDirectory)

#------------------------------------------------#

HackageUser     =sboo
HackagePassword =pass hackage.haskell.org/user/$(HackageUser)

#------------------------------------------------#

GitHubOwner      =sboosali
GitHubRepository =$(Project)

GitHubReleasePostPath ?= /repos/$(GitHubOwner)/$(GitHubRepository)/releases
GitHubReleasePostData ?='{ "tag_name": "v$(Version)", "target_commitish": "master", "name": "v$(Version)", "body": "v$(Version)", "draft": false, "prerelease": false }'
GitHubPublishPostData ?='{ "tag_name": "v$(Version)", "target_commitish": "master", "name": "v$(Version)", "body": "v$(Version)", "draft": true, "prerelease": true }'

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
# Makefile Targets: Cabal -----------------------#
#------------------------------------------------#

docs:

	$(Cabal) new-haddock $(CabalTargets)

.PHONY: docs

#------------------------------------------------#

update:

	cabal new-update $(HaskellRepository)

.PHONY: update

#------------------------------------------------#
# Makefile Targets: Development -----------------#
#------------------------------------------------#

typecheck:
	@printf "\n%s\n" "========================================"

	@printf "%s\n\n" "Typechecking..."

	$(Cabal) new-build $(CabalOptions) --ghc-options="-fno-code -fforce-recomp" $(CabalTargets)

	@printf "\n%s\n" "========================================"

.PHONY: typecheck

#------------------------------------------------#

develop:
	@printf "\n%s\n" "========================================"

	@printf "%s\n\n" "Building (« -f+develop »)..."

	$(Cabal) new-build $(CabalOptions) -f"+develop" $(CabalTargets)

	@printf "\n%s\n" "========================================"

.PHONY: develop

#------------------------------------------------#
# Makefile Targets: Static ----------------------#
#------------------------------------------------#

#------------------------------------------------#
# Makefile Targets: Uploading -------------------#
#------------------------------------------------#

upload-hackage: dist

	@printf "\n%s\n" "========================================"
	@printf "%s\n\n" "Uploading (Hackage)..."

	$(Cabal) upload --username='$(HackageUser)' --password-command='$(HackagePassword)' "$(BuildDirectory)/sdist/$(Package)-$(Version).tar.gz"

	@printf "\n%s\n" "========================================"

.PHONY: upload-hackage

#------------------------------------------------#

publish-hackage: dist

	@printf "\n%s\n" "========================================"
	@printf "%s\n\n" "Publishing (Hackage)..."

	$(Cabal) upload --publish --username='$(HackageUser)' --password-command='$(HackagePassword)' "$(BuildDirectory)/sdist/$(Package)-$(Version).tar.gz"

	@printf "\n%s\n" "========================================"

.PHONY: publish-hackage

#------------------------------------------------#

upload-github: dist

	@printf "\n%s\n" "========================================"
	@printf "%s\n\n" "Uploading (Github)..."


	curl -X POST -H "Content-Type: application/json" --data $(GitHubReleasePostData) $(GitHubReleasePostPath)

	@printf "\n%s\n" "========================================"

.PHONY: upload-github

#------------------------------------------------#

publish-github: dist

	@printf "\n%s\n" "========================================"
	@printf "%s\n\n" "Publishing (Github)..."

	curl -X POST -H "Content-Type: application/json" --data $(GitHubPublishPostData) '$(GitHubReleasePostPath)'

	@printf "\n%s\n" "========================================"

.PHONY: publish-github

#------------------------------------------------#
# Makefile Targets: Releasing -------------------#
#------------------------------------------------#

release: check dist

	@printf "\n%s\n" "========================================"
	@printf "%s\n\n" "Publishing (Hackage)..."

	$(Cabal) upload --publish --username='$(HackageUser)' --password-command='$(HackagePassword)' "$(BuildDirectory)/sdist/$(Package)-$(Version).tar.gz"

	@printf "\n%s\n" "========================================"
	@printf "%s\n\n" "Tagging (Git)..."

	git tag -a "v$(Version)" -m "v$(Version)"
	git push --tags origin master

	@printf "\n%s\n" "========================================"
	@printf "%s\n\n" "Publishing (GitHub)..."

	curl -X POST -H "Content-Type: application/json" --data=$(GitHubPublishPostData) '$(GitHubReleasePostPath)'

	@printf "\n%s\n" "========================================"

.PHONY: release

#------------------------------------------------#
# Notes -----------------------------------------#
#------------------------------------------------#

# Makefile Syntax:
#
# • « $@ » — the target        — (a.k.a. output file(s); a.k.a. the rule's left-hand-side).
# • « $^ » — all prerequisites — (a.k.a. inputs files, space-separated; a.k.a. the rule's right-hand-side).

# GitHub releases:
#
# « POST /repos/:owner/:repo/releases »
#
# « https://developer.github.com/v3/repos/releases/#create-a-release »

#------------------------------------------------#
# EOF -------------------------------------------#
#------------------------------------------------#