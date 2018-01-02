# Configuration
My personal configuration (dotfiles, etc.)

## Setup

### installation of dependencies (via `nix`)

TODO

    nix-build configuration.nix

### symlinks

this

    ./compile-dhall-configuration.sh -f

converts the .dhall to a .sh script and executes it.

in particular, it symlinks everything into this (version controlled) directory, like:

    /home/sboo/.bashrc  ->  /home/sboo/configuration/bash/.bashrc
    ...

it takes a single optional argument, which is passes onto `ln`. for example, this is a safer version that doesn't overwrite anything:

    ./compile-dhall-configuration.sh

## Dependencies

