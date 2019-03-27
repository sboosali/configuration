#!/bin/bash

##################################################

sudo usermod -aG vboxusers "$USER"
sudo usermod -aG vboxsf    "$USER"

##################################################

cat /etc/group | grep 'vbox'

NUMBER_OF_VBOX_GROUPS_USER_IS_MEMBER_OF=$(cat /etc/group | grep 'vbox' | grep "$USER" | wc -l)

if   [ "$NUMBER_OF_VBOX_GROUPS_USER_IS_MEMBER_OF" -ge 2 ]
then exit 0
else exit 1
fi

##################################################

# e.g.
#     vboxusers:x:130:sboo
#     vboxsf:x:131:sboo

