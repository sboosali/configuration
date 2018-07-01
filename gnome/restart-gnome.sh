#!/bin/bash

pkill -HUP gnome-shell

gnome-shell --replace
# lightdm restart
systemctl restart lightdm
