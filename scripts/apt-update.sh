#!/bin/bash

########################################

sudo apt update       --assume-yes
sudo apt upgrade      --assume-yes
sudo apt dist-upgrade --assume-yes
sudo apt autoremove   --assume-yes

apt      list         --upgradable

sudo apt update       --assume-yes
sudo apt upgrade      --assume-yes

########################################

