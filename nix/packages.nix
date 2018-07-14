{ pkgs
}:
########################################
let

with pkgs;

in
########################################
[

 virtualbox
 linuxPackages.virtualboxGuestAdditions
 
 rxvt_unicode-with-plugins
 # ^ rxvt-unicode-with-perl-with-unicode3-with-plugins-9.22

]
########################################
