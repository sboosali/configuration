#!/bin/bash
set -e
set -u

############################################################

SSH_CONFIG_FILE="$HOME"/.ssh/config

SSH_DIR="$HOME"/.ssh/

############################################################

CONFIGURATION=${SBOO_CONFIG_D:-"$HOME/configuration"}

SBOO_SSH_CONFIG_FILE="$CONFIGURATION"/ssh/d/config

############################################################

echo '############################################################'
echo
echo "$SBOO_SSH_CONFIG_FILE"
echo
echo '############################################################'
echo
echo "$SSH_CONFIG_FILE"
echo
echo '############################################################'
echo

mkdir -p "$SSH_DIR"

ln -s $@ "$SBOO_SSH_CONFIG_FILE" "$SSH_CONFIG_FILE"

echo
echo '############################################################'
echo

cat  "$SSH_CONFIG_FILE"

echo
echo '############################################################'
echo

ls -la "$SSH_CONFIG_FILE"

echo
echo '############################################################'
echo

############################################################
