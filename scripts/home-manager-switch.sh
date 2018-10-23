#!/bin/bash
set -eu

HomeFile=/home/sboo/configuration/home-manager/nix/home.nix

NIX_PATH=nixpkgs=/home/sboo/.nix-defexpr/channels/nixpkgs home-manager -f "$HomeFile" switch

