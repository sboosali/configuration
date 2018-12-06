#!/bin/bash
set -e

##################################################

VirtualboxVersion=5.2

Codename=xenial

# ^ See « lsb_release -a ».

RepositoryRegistry=/etc/apt/sources.list

VirtualboxRepository="deb https://download.virtualbox.org/virtualbox/debian ${Codename} contrib"

##################################################

if   ! grep "${VirtualboxRepository}" "${RepositoryRegistry}"
then echo -e "${VirtualboxRepository}\n" | sudo tee -a "${RepositoryRegistry}"
fi

wget -q "https://www.virtualbox.org/download/oracle_vbox.asc" -O- | sudo apt-key add -

sudo apt update

##################################################

sudo apt install --yes "virtualbox-${VirtualboxVersion}"

sudo apt install --yes "virtualbox-ext-pack"
# ^ manually accept EULA. 
sudo apt install --yes "virtualbox-guest-additions-iso"
sudo apt install --yes "virtualbox-qt"

##################################################

virtualbox &disown

##################################################

# > The key fingerprint for « oracle_vbox.asc » is:
# >
# >     7B0F AB3A 13B9 0743 5925  D9C9 5442 2A4B 98AB 5139
# >     Oracle Corporation (VirtualBox archive signing key) <info@virtualbox.org>

# > As part of a pipe tee can take the input, elevate permissions and write to the file.
# > 
# >     $ echo "foo" | sudo tee -a file

# > Usage: grep [OPTION]... PATTERN [FILE]...

