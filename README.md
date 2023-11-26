# Configuration

My personal configuration (dotfiles, etc)

Uses `nix`.


## Files

* `./home-manager/nix/**/*.nix` — my `home-manager`
* `./archives/...` — backup `home-manager` generations (snapshots)
* `./dictation/...` — Notes about Dictation & Instructions for configuring microphones and for installing `Dragon NaturallySpeaking` 15 within a `Windows 10` virtual-machine via `VirtualBox`
* TODO

## Binaries (in `./bin`)

`./bin` holds platform-specific, statically-linked executables. 

only `nix` and `curl` (TODO no `git`?) are necessary for bootstrapping.

to bootstrap, on your platform, register the programs. e.g., on 64-bit Linux:

``` sh
PATH="$(readlink -f ./bin/x86_64-linux):${PATH}"
```

### Binaries: bootstrapping configuring

static `nix`:

``` sh
$ ldd ./bin/x86_64-linux/nix

  not a dynamic executable

$ du -h ./bin/x86_64-linux/nix

  11M

$ ./bin/x86_64-linux/nix --version

  nix (Nix) 2.2
```

### Binaries: bootstrapping haskell

static `ghc`:

``` sh
$ ldd ./bin/x86_64-linux/ghc

  not a dynamic executable

$ du -h ./bin/x86_64-linux/ghc

  4K

$ ./bin/x86_64-linux/ghc --numeric-version

  8.6.4
```

static `cabal`:

``` sh
$ ldd ./bin/x86_64-linux/cabal

  not a dynamic executable

$ du -h ./bin/x86_64-linux/cabal

  18M

$ ./bin/x86_64-linux/cabal --numeric-version

  2.2.0.0
```

### Binaries: convenience

static `pandoc`:

``` sh
$ ldd ./bin/x86_64-linux/pandoc

  not a dynamic executable

$ du -h ./bin/x86_64-linux/pandoc

  39M

$ ./bin/x86_64-linux/pandoc --version

  pandoc 2.2.1
  Compiled with: pandoc-types 1.17.5.1, texmath 0.11.0.1, skylighting 0.7.2
```

<https://github.com/jgm/pandoc/releases/tag/2.7.2>

### 

## Usage

### TODO Startup Scripts

For startup of the system, the display, a terminal, etc. 



## Setup

### get `nix`

    curl https://nixos.org/nix/install | sh


### installation of dependencies (via `nix`)

TODO

    # nix-build configuration.nix
    nix-env -i configuration.nix

### `~/.config/`

Symlink some `~/.config` subdirs from `./config/...`'.

### 'ln -s` symlinks

this

    ./compile-dhall-configuration.sh -f

converts the .dhall to a .sh script and executes it.

in particular, it symlinks everything into this (version controlled) directory, like:

    /home/sboo/.bashrc  ->  /home/sboo/configuration/bash/.bashrc
    ...

it takes a single optional argument, which is passes onto `ln`. for example, this is a safer version that doesn't overwrite anything:

    ./compile-dhall-configuration.sh

### `cp` directly

    ./reconfigure-privileged.sh

    ./configuration-cp.sh


## Dependencies

TODO

see `TODO.nix`


## Installation

Scripts for installaling, upgrading, and bootstrapping: TODO


