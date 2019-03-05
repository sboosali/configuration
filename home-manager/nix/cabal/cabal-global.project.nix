{}:

##################################################
let

config = {

  verbose = 2;
  jobs    = 4;

  nix           = false;
  deterministic = true;
  relocatable   = true;

  documentation = false;
  tests         = false;
  benchmarks    = false;
  coverage      = false;

  allow-older = false;
  allow-newer = false;

  username         = "sboo";
  password-command = "sboo-get-hackage-password";
                    # ^ defined in « ~/.profile ».

  #TODO ''${pass} "www.hackage.com/user/sboo"''

  remote-build-reporting = "detailed";

};

in
##################################################
let

bool = b:
  if b then "True" else "False";

int = builtins.toString;

path = builtins.toString;

in
##################################################
''
--------------------------------------------------
-- Repositories ----------------------------------
--------------------------------------------------

repository stackage-lts-13.9

  url: https://www.stackage.org/lts-13.9

  -- ^ Stackage, GHC-8.6.3 (circa 2019-02-24)
  -- 
  -- See: https://www.stackage.org/lts-13.9/cabal.config?global=true
  -- 

--------------------------------------------------

repository hackage.mobilehaskell

  url: https://hackage.mobilehaskell.org/

  secure:    True
  key-threshold: 3
  root-keys: 8184c1f23ce05ab836e5ebac3c3a56eecb486df503cc28110e699e24792582da
             81ff2b6c5707d9af651fdceded5702b9a6950117a1c39461f4e2c8fc07d2e36a
             8468c561cd02cc7dfe27c56de0da1a5c1a2b1b264fff21f4784f02b8c5a63edd

  -- ^ Mobile (Andriod and iOS)

--------------------------------------------------

repository hackage.haskell.org

  url: https://hackage.haskell.org/

  -- secure:       True
  -- key-threshold: 3
  -- root-keys: 07c59cb65787dedfaef5bd5f987ceb5f7e5ebf88b904bbd4c5cbdeb2ff71b740
  --            2e8555dde16ebd8df076f1a8ef13b8f14c66bad8eafefd7d9e37d0ed711821fb
  --            8f79fd2389ab2967354407ec852cbe73f2e8635793ac446d09461ffb99527f6e

  -- ^ central Hackage server (the default repository).

--------------------------------------------------
-- Settings --------------------------------------
--------------------------------------------------

verbose: ${int config.verbose}
-- {{{ 1 }}}, by default.

jobs: ${int config.jobs}
-- {{{ $ncpus }}}, by default.

--------------------------------------------------

username:         ${config.username}
password-command: ${config.password-command}

remote-build-reporting: ${config.remote-build-reporting}

--------------------------------------------------

extra-prog-path: ${path ~/.cabal/bin}

--------------------------------------------------

nix: ${bool config.nix}

extra-lib-dirs:     ${path ~/.nix-profile/lib}

extra-include-dirs: ${path ~/.nix-profile/include}

extra-prog-path:    ${path ~/.nix-profile/bin}
extra-prog-path:    ${path ~/.nix-profile/libexec}

--------------------------------------------------

deterministic: ${bool config.deterministic}
relocatable:   ${bool config.relocatable}

--------------------------------------------------

-- TODO distinguish null from default/false
-- TODO or, move this under the {{{ package * }}} stanza

documentation:  ${bool config.documentation}
tests:          ${bool config.tests}
benchmarks:     ${bool config.benchmarks}
coverage:       ${bool config.coverage}

--------------------------------------------------

deterministic: ${bool config.deterministic}
relocatable:   ${bool config.relocatable}

--------------------------------------------------

allow-older: ${bool config.allow-older}
allow-newer: ${bool config.allow-newer}

--------------------------------------------------

-- default-user-config:
-- require-sandbox             : False
-- ignore-sandbox              : False
-- ignore-expiry               : False
-- http-transport:
-- nix                         : False
remote-repo-cache              : ${path ~/.cabal/packages}
-- local-repo:
-- logs-dir                    : ${path ~/.cabal/logs}
world-file                     : ${path ~/.cabal/world}
-- store-dir:
-- verbose                     : 1
-- compiler                    : ghc
-- cabal-file:
-- with-compiler:
-- with-hc-pkg:
-- program-prefix              : 
-- program-suffix              : 
-- library-vanilla             : True
-- library-profiling:
-- shared:
-- static:
-- executable-dynamic          : False
-- profiling:
-- executable-profiling:
-- profiling-detail:
-- library-profiling-detail:
-- optimization                : True
-- debug-info                  : False
-- library-for-ghci:
-- split-sections              : False
-- split-objs                  : False
-- executable-stripping        : True
-- library-stripping           : True
-- configure-option:
-- user-install                : True
-- package-db:
-- flags:
-- extra-include-dirs:
-- deterministic:
-- cid:
-- extra-lib-dirs:
-- extra-framework-dirs:
-- extra-prog-path:
-- instantiate-with:
-- tests                       : False
-- coverage                    : False
-- library-coverage:
-- exact-configuration         : False
-- benchmarks                  : False
-- relocatable                 : False
-- response-files:
-- cabal-lib-version:
-- constraint:
-- preference:
-- solver                      : modular
-- allow-older                 : False
-- allow-newer                 : False
-- documentation               : False
-- doc-index-file              : $datadir/doc/$arch-$os-$compiler/index.html
-- target-package-db:
-- max-backjumps               : 2000
-- reorder-goals               : False
-- count-conflicts             : True
-- independent-goals           : False
-- shadow-installed-packages   : False
-- strong-flags                : False
-- allow-boot-library-installs : False
-- reinstall                   : False
-- avoid-reinstalls            : False
-- force-reinstalls            : False
-- upgrade-dependencies        : False
-- index-state:
-- root-cmd:
symlink-bindir                 : ${path ~/.cabal/bin}
build-summary                  : ${path ~/.cabal/logs/build.log}
-- build-log:
-- remote-build-reporting      : anonymous
-- report-planning-failure     : False
-- per-component               : True
-- one-shot                    : False
-- run-tests:
-- keep-going                  : False
-- offline                     : False
-- project-file:
-- username:
-- password:
-- password-command:
-- builddir:

--------------------------------------------------

haddock

  hoogle            : True
  executables       : True
  tests             : True
  benchmarks        : True
  foreign-libraries : True
  internal          : False
  hyperlink-source  : True
  quickjump         : True

  -- keep-temp-files   : False
  -- hoogle            : False
  -- html              : False
  -- html-location:
  -- executables       : False
  -- tests             : False
  -- benchmarks        : False
  -- foreign-libraries : False
  -- all:
  -- internal          : False
  -- css:
  -- hyperlink-source  : False
  -- quickjump         : False
  -- hscolour-css:
  -- contents-location:

--------------------------------------------------

install-dirs user

  --TODO--

  -- prefix        : ${path ~/.cabal}
  -- bindir        : $prefix/bin
  -- libdir        : $prefix/lib
  -- libsubdir     : $abi/$libname
  -- dynlibdir     : $libdir/$abi
  -- libexecdir    : $prefix/libexec
  -- libexecsubdir : $abi/$pkgid
  -- datadir       : $prefix/share
  -- datasubdir    : $abi/$pkgid
  -- docdir        : $datadir/doc/$abi/$pkgid
  -- htmldir       : $docdir/html
  -- haddockdir    : $htmldir
  -- sysconfdir    : $prefix/etc

--------------------------------------------------

install-dirs global

  -- prefix        : /usr/local
  -- bindir        : $prefix/bin
  -- libdir        : $prefix/lib
  -- libsubdir     : $abi/$libname
  -- dynlibdir     : $libdir/$abi
  -- libexecdir    : $prefix/libexec
  -- libexecsubdir : $abi/$pkgid
  -- datadir       : $prefix/share
  -- datasubdir    : $abi/$pkgid
  -- docdir        : $datadir/doc/$abi/$pkgid
  -- htmldir       : $docdir/html
  -- haddockdir    : $htmldir
  -- sysconfdir    : $prefix/etc

--------------------------------------------------

program-locations

  -- alex-location:
  -- ar-location:
  -- c2hs-location:
  -- cpphs-location:
  -- doctest-location:
  -- gcc-location:
  -- ghc-location:
  -- ghc-pkg-location:
  -- ghcjs-location:
  -- ghcjs-pkg-location:
  -- greencard-location:
  -- haddock-location:
  -- happy-location:
  -- haskell-suite-location:
  -- haskell-suite-pkg-location:
  -- hmake-location:
  -- hpc-location:
  -- hsc2hs-location:
  -- hscolour-location:
  -- jhc-location:
  -- ld-location:
  -- pkg-config-location:
  -- runghc-location:
  -- strip-location:
  -- tar-location:
  -- uhc-location:

--------------------------------------------------

program-default-options

  -- alex-options:
  -- ar-options:
  -- c2hs-options:
  -- cpphs-options:
  -- doctest-options:
  -- gcc-options:
  -- ghc-options:
  -- ghc-pkg-options:
  -- ghcjs-options:
  -- ghcjs-pkg-options:
  -- greencard-options:
  -- haddock-options:
  -- happy-options:
  -- haskell-suite-options:
  -- haskell-suite-pkg-options:
  -- hmake-options:
  -- hpc-options:
  -- hsc2hs-options:
  -- hscolour-options:
  -- jhc-options:
  -- ld-options:
  -- pkg-config-options:
  -- runghc-options:
  -- strip-options:
  -- tar-options:
  -- uhc-options:

--------------------------------------------------
''