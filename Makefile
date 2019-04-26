##################################################
# Makefile Settings ##############################
##################################################

SHELL=bash

.EXPORT_ALL_VARIABLES:

##################################################
# Makefile Variables #############################
##################################################

Timestamp ?=$(shell date +%d-%m-%Y+%H:%M)

#------------------------------------------------#

HM_FILE    ?=${HOME}/configuration/home-manager/nix/home.nix

#------------------------------------------------#

EmacsDirectory ?=${HOME}/.emacs.d

EmacsSubDirectory ?=$(EmacsDirectory)/sboo

#------------------------------------------------#

HM ?=home-manager

#HM_FILE    ?=${HOME}/configuration/home-manager/nix/home.nix
#HM_FILE    ?=./configuration/home-manager/nix/home.nix

HM_PATH ?=~/configuration/submodules/h

HM_NIXPKGS ?=

# HM_NIXPKGS ?=<nixpkgs>
# HM_NIXPKGS ?=${HOME}/.nix-defexpr/channels/nixos-18.09
# HM_NIXPKGS ?=https://nixos.org/channels/nixos-18.09

#------------------------------------------------#

NIX_OPTIONS ?=--show-trace

#------------------------------------------------#

Nix      ?=nix
NixBuild ?=nix-build --show-trace
NixShell ?=nix-shell --show-trace

#------------------------------------------------#

Emacs ?=emacs

EmacsBuild ?=emacs -batch  --funcall=batch-byte-compile  --directory=$(EmacsSubDirectory)

EmacsOptions ?=--name=Emacs/SBoo/$(Timestamp) --no-desktop --maximized --no-splash

#------------------------------------------------#

##################################################
# Makefile Targets ###############################
##################################################

default: build

.PHONY: default

#------------------------------------------------#

configure: bootstrap

# ^ not « .PHONY », writes the « .gitignore »'d « ./configure » script.

#------------------------------------------------#

build: home-manager

.PHONY: build

#------------------------------------------------#

check: build

.PHONY: check

#================================================#
# Home Manager ==================================#
#================================================#

bootstrap:



.PHONY: bootstrap

#------------------------------------------------#

nixos-19.03:

	NIX_PATH=nixpkgs=nixos-19.03 $(HM) -f $(HM_FILE) build

.PHONY: nixos-19.03


home-manager:

	$(HM) -f $(HM_FILE) build


#	                               $(HM) -f $(HM_FILE) build
#	NIX_PATH=nixpkgs=$(HM_NIXPKGS) $(HM) -f $(HM_FILE) build

.PHONY: home-manager

#------------------------------------------------#

switch:

	HOME_MANAGER_CONFIG=$(HM_FILE) $(HM) -v -f $(HM_FILE) switch

.PHONY: switch

#------------------------------------------------#

build-home:

	$(NixBuild) $(HM_FILE) --out-link "./result-home"

.PHONY: build-home

# ^ build « home.nix » with « nix-build --show-trace »
#   (not with « home-manager build »).

#------------------------------------------------#

#================================================#
# Emacs =========================================#
#================================================#

# emacs:
# .PHONY: emacs

#------------------------------------------------#

emacs-run: build  #TODO# emacs-build

	exec $(Emacs) $(EmacsOptions) &disown

.PHONY: emacs-run

#------------------------------------------------#

emacs-debug: build  #TODO# emacs-build

	SBOO_EMACS_DESKTOP=0 $(Emacs) $(EmacsOptions) --debug-init

.PHONY: emacs-debug

#------------------------------------------------#

emacs-build: #TODO

	$(EmacsBuild) $(EmacsSubDirectory)/*.el

.PHONY: emacs-build

#------------------------------------------------#

emacs-clean:

	find "$(EmacsSubDirectory)" -type f -name '*.elc' -print
	find "$(EmacsSubDirectory)" -type f -name '*.elc' -delete

.PHONY: emacs-clean

#================================================#
# Installation ==================================#
#================================================#

# installing/configuring dependencies.

#------------------------------------------------#

apt-install:

        #----------------------#

	sudo apt update

        #----------------------#

	sudo apt install -y "virtualbox-5.1"
	sudo apt install -y "virtualbox-guest-additions-iso"
	sudo apt install -y "virtualbox-ext-pack"

	sudo apt install -y "exfat-utils"

	sudo apt install -y "freeglut3-dev"

	sudo apt install -y "portaudio19-dev"

	sudo apt install -y "lightdm"
	sudo apt install -y "xubuntu-desktop"

	sudo apt install -y "paper-icon-theme"

#	sudo apt install -y ""

        #----------------------#

	sudo apt install -y "locales"
	sudo apt install -y "language-pack-en"

	sudo locale-gen en_US.UTF-8
	sudo dpkg-reconfigure locales

        #----------------------#

	sudo ln -s $(HOME)/.nix-profile/bin/emacs /usr/bin/emacs

        #----------------------#

.PHONY: apt-install

#------------------------------------------------#

apt-uninstall-ubuntu:

# $ sudo apt remove bamfdaemon
#
# Reading package lists... Done
# Building dependency tree
# Reading state information... Done
# The following packages will be REMOVED:
#   bamfdaemon ubuntu-desktop unity

        #----------------------#

	sudo apt-get remove account-plugin-aim account-plugin-facebook account-plugin-flickr account-plugin-google account-plugin-icons account-plugin-identica account-plugin-jabber account-plugin-salut account-plugin-twitter account-plugin-windows-live account-plugin-yahoo activity-log-manager-common activity-log-manager-control-center adium-theme-ubuntu aisleriot apg appmenu-gtk appmenu-gtk3 appmenu-qt apturl apturl-common bamfdaemon baobab bluez-gstreamer branding-ubuntu brasero brasero-cdrkit brasero-common checkbox checkbox-qt compiz compiz-core compiz-gnome compiz-plugins-default cracklib-runtime cryptsetup-bin dconf-tools deja-dup duplicity dvd+rw-tools empathy empathy-common eog evolution-data-server evolution-data-server-common example-content folks-common freerdp-x11 gedit gedit-common geoclue geoclue-ubuntu-geoip gir1.2-accounts-1.0 gir1.2-dbusmenu-glib-0.4 gir1.2-dee-1.0 gir1.2-gdata-0.0 gir1.2-gnomebluetooth-1.0 gir1.2-gnomekeyring-1.0 gir1.2-goa-1.0 gir1.2-gst-plugins-base-0.10 gir1.2-gstreamer-0.10 gir1.2-gtksource-3.0 gir1.2-indicate-0.7 gir1.2-messagingmenu-1.0 gir1.2-notify-0.7 gir1.2-peas-1.0 gir1.2-rb-3.0 gir1.2-signon-1.0 gir1.2-syncmenu-0.1 gir1.2-totem-1.0 gir1.2-totem-plparser-1.0 gir1.2-ubuntuoneui-3.0 gir1.2-unity-5.0 gnome-bluetooth gnome-contacts gnome-control-center gnome-control-center-data gnome-control-center-signon gnome-desktop3-data gnome-disk-utility gnome-font-viewer gnome-icon-theme-symbolic gnome-mahjongg gnome-media gnome-menus gnome-online-accounts gnome-orca gnome-power-manager gnome-screensaver gnome-screenshot gnome-session gnome-session-bin gnome-session-canberra gnome-session-common gnome-settings-daemon gnome-system-log gnome-system-monitor gnome-terminal gnome-terminal-data gnome-user-share growisofs gstreamer0.10-gconf guile-1.8-libs gwibber gwibber-service gwibber-service-facebook gwibber-service-identica gwibber-service-twitter hwdata indicator-appmenu indicator-datetime indicator-messages indicator-power indicator-printers indicator-session intel-gpu-tools landscape-client-ui-install libaccount-plugin-1.0-0 libaccounts-glib0 libaccounts-qt1 libatk-adaptor libatk-adaptor-data libaudio2 libavahi-gobject0 libbamf3-0 libboost-date-time1.49.0 libbrasero-media3-1 libcamel-1.2-40 libcanberra-gtk-module libcanberra-gtk0 libcanberra-pulse libclutter-1.0-0 libclutter-1.0-common libclutter-gst-1.0-0 libclutter-gtk-1.0-0 libcmis-0.2-2 libcogl-common libcogl-pango0 libcogl9 libcompizconfig0 libcrack2 libcrypt-passwdmd5-perl libcryptsetup4 libcurl3-nss libdbusmenu-qt2 libdecoration0 libdee-1.0-4 libdiscid0 libdmapsharing-3.0-2 libebackend-1.2-5 libebook-1.2-14 libecal-1.2-15 libedata-book-1.2-15 libedata-cal-1.2-18 libedataserver-1.2-17 libexempi3 libexttextcat-1.0-0 libexttextcat-data libfolks-eds25 libfolks-telepathy25 libfolks25 libfreerdp-plugins-standard libfreerdp1 libgail-common libgail18 libgdata-common libgdata13 libgexiv2-1 libglew1.8 libglewmx1.8 libgmime-2.6-0 libgnome-control-center1 libgnome-desktop-3-4 libgnome-media-profiles-3.0-0 libgnome-menu2 libgnomekbd-common libgnomekbd8 libgoa-1.0-0 libgoa-1.0-common libgpgme11 libgpod-common libgpod4 libgtksourceview-3.0-0 libgtksourceview-3.0-common libgtkspell-3-0 libgweather-3-1 libgweather-common libgwibber-gtk3 libgwibber3 libhyphen0 libjs-jquery liblircclient0 liblouis-data liblouis2 liblvm2app2.2 libmessaging-menu0 libmetacity-private0a libmission-control-plugins0 libmng1 libmtp-common libmtp-runtime libmtp9 libmusicbrainz5-0 libmx-1.0-2 libmx-bin libmx-common libmysqlclient18 libmythes-1.2-0 libneon27-gnutls libnux-3.0-0 libnux-3.0-common liboauth0 libpackagekit-glib2-14 libpam-freerdp libpeas-1.0-0 libpeas-common libprotobuf7 libprotoc7 libproxy1-plugin-gsettings libproxy1-plugin-networkmanager libpth20 libpwquality1 libpython3.2 libqjson0 libqt4-dbus libqt4-declarative libqt4-designer libqt4-help libqt4-network libqt4-script libqt4-scripttools libqt4-sql libqt4-sql-mysql libqt4-sql-sqlite libqt4-svg libqt4-test libqt4-xml libqt4-xmlpatterns libqtassistantclient4 libqtcore4 libqtgui4 libqtwebkit4 libquvi-scripts libquvi7 libraw5 libreoffice-base-core libreoffice-calc libreoffice-common libreoffice-core libreoffice-draw libreoffice-emailmerge libreoffice-gnome libreoffice-gtk libreoffice-help-en-us libreoffice-impress libreoffice-math libreoffice-ogltrans libreoffice-pdfimport libreoffice-presentation-minimizer libreoffice-presenter-console libreoffice-style-human libreoffice-style-tango libreoffice-writer librest-0.7-0 librhythmbox-core6 librsync1 libsgutils2-2 libsignon-extension1 libsignon-glib1 libsignon-plugins-common1 libsignon-qt1 libssh-4 libstlport4.6ldbl libsync-menu1 libsyncdaemon-1.0-1 libtelepathy-farstream2 libtelepathy-logger2 libtimezonemap1 libtotem-plparser17 libtotem0 libubuntuoneui-3.0-1 libufe-xidgetter0 libunity-core-6.0-5 libunity-misc4 libunity-protocol-private0 libunity-webapps0 libunity9 libvncserver0 libwacom-common libwacom2 libwmf0.2-7-gtk libzeitgeist-1.0-1 light-themes lightdm-remote-session-freerdp lightdm-remote-session-uccsconfigure linux-headers-generic-pae mcp-account-manager-uoa media-player-info metacity-common mousetweaks mysql-common nautilus nautilus-sendto nautilus-sendto-empathy nautilus-share notify-osd notify-osd-icons nux-tools obexd-client overlay-scrollbar overlay-scrollbar-gtk2 overlay-scrollbar-gtk3 plymouth-theme-ubuntu-logo protobuf-compiler pulseaudio-module-bluetooth pulseaudio-module-gconf python-apport python-configglue python-gnupginterface python-mako python-markupsafe python-problem-report python-protobuf python-pyinotify python-qt4 python-qt4-dbus python-simplejson python-sip python-twisted-names python-ubuntuone-client python-ubuntuone-control-panel python-ubuntuone-storageprotocol python-uno python-zeitgeist python3-brlapi python3-crypto python3-httplib2 python3-louis python3-lxml python3-oauthlib python3-pyatspi2 python3-pycurl python3-speechd qdbus qt-at-spi remmina remmina-common remmina-plugin-rdp remmina-plugin-vnc remote-login-service rhythmbox rhythmbox-data rhythmbox-mozilla rhythmbox-plugin-cdrecorder rhythmbox-plugin-magnatune rhythmbox-plugin-zeitgeist rhythmbox-plugins rhythmbox-ubuntuone seahorse session-migration shotwell signon-keyring-extension signon-plugin-oauth2 signon-plugin-password signon-ui signond sni-qt ssh-askpass-gnome syslinux syslinux-common syslinux-legacy telepathy-gabble telepathy-haze telepathy-idle telepathy-indicator telepathy-logger telepathy-mission-control-5 telepathy-salut thin-client-config-agent thunderbird-gnome-support totem totem-common totem-mozilla totem-plugins ubuntu-artwork ubuntu-desktop ubuntu-docs ubuntu-mono ubuntu-settings ubuntu-sounds ubuntu-sso-client-qt ubuntu-system-service ubuntu-wallpapers ubuntu-wallpapers-quantal ubuntuone-client ubuntuone-client-gnome ubuntuone-control-panel ubuntuone-control-panel-qt ubuntuone-couch udisks unity unity-asset-pool unity-common unity-greeter unity-lens-applications unity-lens-files unity-lens-gwibber unity-lens-music unity-lens-photos unity-lens-shopping unity-lens-video unity-scope-gdocs unity-scope-musicstores unity-scope-video-remote unity-services unity-webapps-common unity-webapps-service uno-libs3 ure usb-creator-common usb-creator-gtk vino wodim xdiagnose xfonts-mathml xul-ext-unity xul-ext-websites-integration zeitgeist zeitgeist-core zeitgeist-datahub

        #----------------------#

	sudo apt-get install xubuntu-desktop
	sudo /usr/lib/lightdm/lightdm-set-defaults -g lightdm-gtk-greeter

        #----------------------#

.PHONY: apt-uninstall-ubuntu

# NOTE this keeps around the rest of Xubuntu.

#------------------------------------------------#

manual-install:

        #----------------------#

	wget "https://ftp.gnu.org/gnu/bash/bash-3.2.tar.gz"
	tar -xv  -f bash-3.2.tar.gz  bash-3.2
	cd ./bash-3.2
	(./configure  &&  make bash)

        #----------------------#

.PHONY: manual-install

#------------------------------------------------#

# nix-install:

# 	nix-env --install ""
# 	nix-env --install ""
# 	nix-env --install ""

# .PHONY: nix-install

#------------------------------------------------#

##################################################
# Notes ##########################################
##################################################

#------------------------------------------------#
# « apt »:

# virtualbox				/xenial-updates,xenial-security,now 5.1.38-dfsg-0ubuntu1.16.04.2 amd64
# virtualbox-ext-pack			/xenial-updates,xenial-updates,now 5.1.38-0ubuntu1.16.04.1 all
# virtualbox-guest-additions-iso	/xenial-updates,xenial-updates,now 5.1.38-0ubuntu1.16.04.1 all

#------------------------------------------------#



#------------------------------------------------#
##################################################
