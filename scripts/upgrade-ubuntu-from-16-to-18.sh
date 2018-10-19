#!/bin/bash

########################################

sudo apt update  --assume-yes
sudo apt install --assume-yes update-manager-core

echo '/etc/update-manager/release-upgrades'
echo
echo '[Default]'
echo 'Prompt=lts'
echo
echo
echo 'sudo nano /etc/update-manager/release-upgrades'

sudo do-release-upgrade -d

########################################

