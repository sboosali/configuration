#!/bin/bash
set -e
set -u

SSH_CONFIG_FILE="$HOME"/.ssh/config

chmod +rw     "$SSH_CONFIG_FILE"
chown "$USER" "$SSH_CONFIG_FILE"

