# Configuration
My personal configuration (dotfiles, etc)

Uses `nix`.


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

## 

