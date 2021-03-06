#!/bin/bash
# -*- buffer-read-only: t; -*- 

########################################

sudo apt update       --assume-yes
sudo apt upgrade      --assume-yes
sudo apt dist-upgrade --assume-yes
sudo apt autoremove   --assume-yes

apt      list         --upgradable

sudo apt update       --assume-yes
sudo apt upgrade      --assume-yes

########################################

sudo apt-get install --assume-yes lightdm
sudo dpkg-reconfigure lightdm

########################################

sudo apt-get install --assume-yes curl

curl https://nixos.org/nix/install | sh

########################################

# $ nix repl
# nix-repl> :a (import <nixpkgs> {})
# nix-repl> :i redshift
# nix-repl> :i xrandr-invert-colors
# nix-repl> :i xdotool
# nix-repl> :i xclip

alias screen-white='redshift -x'
alias screen-red='redshift -O 1000'
alias screen-yellow='redshift -O 2000'
alias screen-invert='xrandr-invert-colors'

alias copy="xclip -selection clipboard"
alias paste="xclip -selection clipboard -o"

function copy-from-file () {
  cat "${1:?}" | xclip -selection clipboard
}
function paste-to-file () {
  xclip -selection clipboard -o > "${1:?}"  
}

########################################

sudo apt-get install --assume-yes git

mkdir cd ~/.ssh/ && cd ~/.ssh/

ssh-keygen -t rsa -b 4096 -C "samboosalis@gmail.com" -f ~/.ssh/SpirOS_git@github.com_id_rsa

cat > ~/.ssh/config <<EOF
########################################

# %l = local hostname (`\`hostname\``)
# %r = remote username (`"git"`)
# %h = remote hostname (`"github.com"`)

########################################

Host *
    Port 22
    ServerAliveInterval 60


########################################
# GitHub as sboosali

Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/%l_%r@%h_id_rsa

########################################
EOF

export GIT_SSH_COMMAND='ssh -i ~/.ssh/SpirOS_git@github.com_id_rsa'

# ^ default ssh identity-file for git,
# which by default, for me, is the sboosali account on GitHub.

eval "$(ssh-agent -s)"

# ^ start the ssh-key daemon

ssh-add ~/.ssh/SpirOS_git@github.com_id_rsa

# ^ register the ssh-key

########################################

cd ~ && git clone git@github.com:sboosali/configuration.git && cd configuration/

########################################

cd ~ && git clone git@github.com:sboosali/.emacs.d.git && cd .emacs.d/

########################################

# Problem:

    $ sudo apt-get update
    *** Error in `appstreamcli': double free or corruption (fasttop): 0x0000000001166b20 ***
    ....

# Solution:

sudo apt-get dist-upgrade

# ^ upgrades 16.04 to 16.04.03 (i.e., patch-version bump).

#sudo apt-get remove appstream

# ^ only remove appstream (dependency of ubuntu-software) if necessary.

########################################

apt list --upgradable

sudo apt update --assume-yes
sudo apt upgrade --assume-yes

sudo apt update --assume-yes
sudo apt upgrade --assume-yes

sudo apt autoremove --assume-yes

apt list --upgradable

########################################

# sudo add-apt-repository ppa:kubuntu-ppa/backports
# sudo apt update --assume-yes
# time sudo apt install --assume-yes kubuntu-desktop

########################################

time sudo apt install --assume-yes plasma-desktop

sudo reboot

########################################

kinfocenter 2>/dev/null &disown

########################################

home-manager build
home-manager switch

########################################
## stdout...

# The following packages will be upgraded:
#   accountsservice activity-log-manager adium-theme-ubuntu adwaita-icon-theme appstream apt apt-transport-https apt-utils aptdaemon aptdaemon-data apturl apturl-common
#   avahi-autoipd avahi-daemon avahi-utils baloo-kf5 bamfdaemon base-files bash-completion berlinetta-p-mlk-meta binutils bluedevil breeze breeze-cursor-theme
#   breeze-icon-theme brltty bsdutils btrfs-tools ca-certificates-java canonical-poke casper cifs-utils columbia-meta command-not-found command-not-found-data compiz
#   compiz-core compiz-gnome compiz-plugins compiz-plugins-default console-setup console-setup-linux coreutils cracklib-runtime cryptsetup-bin dbus dbus-x11 deja-dup
#   desktop-file-utils dh-python dkms dmidecode dpkg dpkg-dev fonts-noto-cjk fonts-opensymbol frameworkintegration friendly-recovery fuse fwupd fwupdate fwupdate-signed
#   gir1.2-appindicator3-0.1 gir1.2-dbusmenu-glib-0.4 gir1.2-gdkpixbuf-2.0 gir1.2-gstreamer-1.0 gir1.2-gtk-3.0 gir1.2-ibus-1.0 gir1.2-javascriptcoregtk-4.0
#   gir1.2-packagekitglib-1.0 gir1.2-unity-5.0 gir1.2-webkit2-4.0 glib-networking glib-networking-common glib-networking-services gnome-accessibility-themes
#   gnome-calculator gnome-calendar gnome-disk-utility gnome-font-viewer gnome-menus gnome-session-bin gnome-session-common gnome-settings-daemon-schemas gnome-software
#   gnome-software-common gnome-sudoku gnome-system-monitor google-chrome-stable grep grub-common grub-efi-amd64 grub-efi-amd64-bin grub-efi-amd64-signed grub2-common
#   gstreamer1.0-tools gtk2-engines-murrine guile-2.0-libs gvfs gvfs-backends gvfs-bin gvfs-common gvfs-daemons gvfs-fuse gvfs-libs gwakeonlan hdparm hicolor-icon-theme
#   humanity-icon-theme ibus ibus-gtk ibus-gtk3 ifupdown im-config indicator-application init init-system-helpers initramfs-tools initramfs-tools-bin
#   initramfs-tools-core intltool iproute2 isc-dhcp-client isc-dhcp-common kbd kde-cli-tools kde-cli-tools-data kde-config-gtk-style kde-config-screenlocker
#   kde-config-sddm kde-style-breeze kde-style-breeze-qt4 kde-style-oxygen-qt5 kde-style-qtcurve-qt4 kde-style-qtcurve-qt5 kded5 kdelibs5-data kdoctools5
#   keyboard-configuration kgamma5 khelpcenter khotkeys khotkeys-data kinfocenter kinit kio kio-extras kio-extras-data klibc-utils kmenuedit kpackagelauncherqml
#   kpackagetool5 krb5-locales kscreen ksshaskpass ksysguard ksysguard-data ksysguardd ktexteditor-data ktexteditor-katepart kwalletmanager kwayland-data
#   kwayland-integration kwin kwin-common kwin-data kwin-style-breeze kwin-x11 kwrited language-pack-en language-pack-en-base language-pack-gnome-en
#   language-pack-gnome-en-base language-selector-common language-selector-gnome less lib32z1 libaccountsservice0 libappindicator1 libappindicator3-1 libappstream-glib8
#   libappstream3 libapt-inst2.0 libapt-pkg5.0 libaudit-common libaudit1 libavahi-client3 libavahi-common-data libavahi-common3 libavahi-core7 libavahi-glib1
#   libavahi-ui-gtk3-0 libbamf3-2 libblkid1 libboost-date-time1.58.0 libboost-filesystem1.58.0 libboost-iostreams1.58.0 libboost-log1.58.0 libboost-regex1.58.0
#   libboost-system1.58.0 libboost-thread1.58.0 libbrlapi0.6 libclick-0.4-0 libcompizconfig0 libcrack2 libcryptsetup4 libcuda1-370 libdbus-1-3 libdbusmenu-glib4
#   libdbusmenu-gtk3-4 libdbusmenu-gtk4 libdecoration0 libdfu1 libdpkg-perl libdrm-intel1 libdrm-nouveau2 libdrm-radeon1 libegl1-mesa libepoxy0 libfcitx-config4
#   libfcitx-gclient0 libfcitx-utils0 libfdisk1 libframe6 libfuse2 libfwup0 libfwupd1 libgail-3-0 libgail-common libgail18 libgbm1 libgdk-pixbuf2.0-0
#   libgdk-pixbuf2.0-common libgif7 libgl1-mesa-dri libgl1-mesa-glx libglapi-mesa libgnome-menu-3-0 libgnutls-openssl27 libgnutls30 libgpgme11 libgssapi-krb5-2
#   libgstreamer1.0-0 libgtk-3-0 libgtk-3-bin libgtk-3-common libgtk2.0-0 libgtk2.0-bin libgtk2.0-common libgweather-3-6 libgweather-common libibus-1.0-5 libido3-0.1-0
#   libinput10 libjavascriptcoregtk-4.0-18 libk5crypto3 libkdecorations2-5v5 libkdecorations2private5v5 libkdecore5 libkdeui5 libkf5activities5
#   libkf5activitiesexperimentalstats1 libkf5archive5 libkf5attica5 libkf5auth-data libkf5auth5 libkf5baloo5 libkf5balooengine5 libkf5bluezqt-data libkf5bluezqt6
#   libkf5bookmarks-data libkf5bookmarks5 libkf5calendarevents5 libkf5codecs-data libkf5codecs5 libkf5completion-data libkf5completion5 libkf5config-bin
#   libkf5config-data libkf5configcore5 libkf5configgui5 libkf5configwidgets-data libkf5configwidgets5 libkf5coreaddons-data libkf5coreaddons5 libkf5crash5
#   libkf5dbusaddons-bin libkf5dbusaddons-data libkf5dbusaddons5 libkf5declarative-data libkf5declarative5 libkf5dnssd-data libkf5dnssd5 libkf5emoticons-bin
#   libkf5emoticons-data libkf5emoticons5 libkf5filemetadata-bin libkf5filemetadata-data libkf5filemetadata3 libkf5globalaccel-bin libkf5globalaccel-data
#   libkf5globalaccel5 libkf5globalaccelprivate5 libkf5gpgmepp5 libkf5guiaddons5 libkf5i18n-data libkf5i18n5 libkf5iconthemes-bin libkf5iconthemes-data libkf5iconthemes5
#   libkf5idletime5 libkf5itemmodels5 libkf5itemviews-data libkf5itemviews5 libkf5jobwidgets-data libkf5jobwidgets5 libkf5js5 libkf5jsembed-data libkf5jsembed5
#   libkf5kcmutils-data libkf5kcmutils5 libkf5kdelibs4support-data libkf5kdelibs4support5 libkf5kdelibs4support5-bin libkf5khtml-bin libkf5khtml-data libkf5khtml5
#   libkf5kiocore5 libkf5kiofilewidgets5 libkf5kiontlm5 libkf5kiowidgets5 libkf5networkmanagerqt6 libkf5newstuff-data libkf5newstuff5 libkf5notifications-data
#   libkf5notifications5 libkf5notifyconfig-data libkf5notifyconfig5 libkf5package-data libkf5package5 libkf5parts-data libkf5parts-plugins libkf5parts5
#   libkf5people-data libkf5people5 libkf5peoplebackend5 libkf5peoplewidgets5 libkf5plasma5 libkf5plasmaquick5 libkf5pty-data libkf5pty5 libkf5quickaddons5 libkf5runner5
#   libkf5screen-bin libkf5service-bin libkf5service-data libkf5service5 libkf5solid5 libkf5solid5-data libkf5sonnet5-data libkf5sonnetcore5 libkf5sonnetui5 libkf5style5
#   libkf5su-bin libkf5su-data libkf5su5 libkf5sysguard-bin libkf5sysguard-data libkf5texteditor5 libkf5texteditor5-libjs-underscore libkf5textwidgets-data
#   libkf5textwidgets5 libkf5threadweaver5 libkf5wallet-bin libkf5wallet-data libkf5wallet5 libkf5waylandclient5 libkf5waylandserver5 libkf5widgetsaddons-data
#   libkf5widgetsaddons5 libkf5windowsystem-data libkf5windowsystem5 libkf5xmlgui-bin libkf5xmlgui-data libkf5xmlgui5 libkf5xmlrpcclient-data libkf5xmlrpcclient5
#   libkfontinst5 libkfontinstui5 libklibc libkrb5-3 libkrb5support0 libkscreenlocker5 libksgrd7 libksignalplotter7 libkwalletbackend5-5 libkwin4-effect-builtins1
#   libkworkspace5-5 libldap-2.4-2 libllvm3.8 libmbim-glib4 libmbim-proxy libmetacity-private3a libmm-glib0 libmount1 libnautilus-extension1a libnm-glib-vpn1 libnm-glib4
#   libnm-gtk-common libnm-gtk0 libnm-util2 libnm0 libnma-common libnma0 libnux-4.0-0 libnux-4.0-common liboxygenstyle5-5 liboxygenstyleconfig5-5 libp11-kit0
#   libpackagekit-glib2-16 libpam-kwallet5 libpam-modules libpam-modules-bin libpam-runtime libpam-systemd libpam0g libparted2 libpci3 libplasma-geolocation-interface5
#   libplymouth4 libpowerdevilcore2 libpowerdevilui5 libprocesscore7 libprocessui7 libpulse-mainloop-glib0 libpulse0 libpulsedsp libpython-stdlib libpython2.7
#   libpython2.7-minimal libpython2.7-stdlib libqgsttools-p1 libqmi-proxy libqt4-dbus libqt4-declarative libqt4-network libqt4-script libqt4-sql libqt4-sql-mysql
#   libqt4-sql-sqlite libqt4-svg libqt4-xml libqt4-xmlpatterns libqt5clucene5 libqt5concurrent5 libqt5core5a libqt5dbus5 libqt5designer5 libqt5designercomponents5
#   libqt5gui5 libqt5help5 libqt5multimedia5 libqt5multimedia5-plugins libqt5multimediaquick-p5 libqt5multimediawidgets5 libqt5network5 libqt5opengl5 libqt5positioning5
#   libqt5printsupport5 libqt5qml5 libqt5quick5 libqt5quicktest5 libqt5quickwidgets5 libqt5script5 libqt5sql5 libqt5sql5-sqlite libqt5svg5 libqt5test5
#   libqt5waylandclient5 libqt5webkit5 libqt5widgets5 libqt5x11extras5 libqt5xml5 libqtcore4 libqtcurve-utils2 libqtdbus4 libqtgui4 libreoffice-avmedia-backend-gstreamer
#   libreoffice-base-core libreoffice-calc libreoffice-common libreoffice-core libreoffice-draw libreoffice-gnome libreoffice-gtk libreoffice-impress libreoffice-math
#   libreoffice-ogltrans libreoffice-pdfimport libreoffice-style-breeze libreoffice-style-galaxy libreoffice-writer libsane libsane-common libseccomp2 libslang2
#   libsmartcols1 libsmbclient libsmbios2v5 libsnmp-base libsnmp30 libsystemd0 libudev1 libunity-control-center1 libunity-core-6.0-9 libunity-protocol-private0
#   libunity-scopes-json-def-desktop libunity-settings-daemon1 libunity9 libupower-glib3 libuuid1 libwacom-bin libwacom-common libwacom2 libwayland-egl1-mesa
#   libwbclient0 libweather-ion7 libwebkit2gtk-4.0-37 libwebkit2gtk-4.0-37-gtk2 libwhoopsie0 libxatracker2 libzen0v5 light-themes linux-firmware linux-generic
#   linux-headers-generic linux-image-generic linux-signed-generic linux-signed-image-generic logrotate lsb-base lsb-release lshw makedev metacity metacity-common milou
#   modemmanager mount mtools mtr-tiny mythes-en-us nano nautilus nautilus-data network-manager network-manager-gnome nux-tools nvidia-370 nvidia-libopencl1-370
#   nvidia-opencl-icd-370 oem-audio-hda-daily-dkms os-prober overlay-scrollbar overlay-scrollbar-gtk2 oxygen-sounds p11-kit p11-kit-modules parted pciutils
#   plasma-desktop plasma-desktop-data plasma-framework plasma-look-and-feel-org-kde-breezedark-desktop plasma-pa plasma-workspace plymouth plymouth-label
#   plymouth-theme-ubuntu-logo plymouth-theme-ubuntu-text polkit-kde-agent-1 powerdevil powerdevil-data printer-driver-brlaser pulseaudio pulseaudio-module-bluetooth
#   pulseaudio-module-x11 pulseaudio-utils python python-apt python-apt-common python-aptdaemon python-aptdaemon.gtk3widgets python-libsmbios python-minimal python-samba
#   python2.7 python2.7-minimal python3-apt python3-aptdaemon python3-aptdaemon.gtk3widgets python3-brlapi python3-commandnotfound python3-pyparsing
#   python3-software-properties python3-uno python3-update-manager python3-urllib3 qdbus qdbus-qt5 qml-module-org-kde-activities qml-module-org-kde-bluezqt
#   qml-module-org-kde-draganddrop qml-module-org-kde-extensionplugin qml-module-org-kde-kcoreaddons qml-module-org-kde-kio qml-module-org-kde-kquickcontrols
#   qml-module-org-kde-kquickcontrolsaddons qml-module-org-kde-kwindowsystem qml-module-org-kde-runnermodel qml-module-org-kde-solid qml-module-qt-labs-folderlistmodel
#   qml-module-qt-labs-settings qml-module-qtgraphicaleffects qml-module-qtmultimedia qml-module-qtquick-controls qml-module-qtquick-controls-styles-breeze
#   qml-module-qtquick-dialogs qml-module-qtquick-layouts qml-module-qtquick-privatewidgets qml-module-qtquick-window2 qml-module-qtquick2 qml-module-qttest qmlscene
#   qtchooser qtcore4-l10n qtdeclarative5-dev-tools qtdeclarative5-qtquick2-plugin qtdeclarative5-test-plugin qtdeclarative5-window-plugin qttools5-dev-tools
#   qttranslations5-l10n qtwayland5 resolvconf rfkill samba-common samba-common-bin samba-libs sane-utils sbsigntool session-shortcuts shared-mime-info shim shim-signed
#   shotwell shotwell-common smbios-utils snapd sni-qt software-properties-common software-properties-gtk sonnet-plugins squashfs-tools sudo suru-icon-theme systemd
#   systemd-sysv systemsettings thermald ubuntu-artwork ubuntu-core-launcher ubuntu-docs ubuntu-minimal ubuntu-mobile-icons ubuntu-mono ubuntu-session ubuntu-software
#   ubuntu-standard udev unattended-upgrades unity unity-control-center unity-control-center-faces unity-lens-applications unity-schemas unity-scopes-runner
#   unity-services unity-settings-daemon uno-libs3 update-manager update-manager-core update-notifier update-notifier-common upower upstart ure user-manager util-linux
#   uuid-runtime vino whoopsie wireless-regdb x11-common xbrlapi xdg-user-dirs xdiagnose xfonts-utils xinit xorg xserver-common xserver-xorg xserver-xorg-core
#   xserver-xorg-input-all xserver-xorg-video-all xserver-xorg-video-amdgpu xserver-xorg-video-intel zlib1g
# 717 upgraded, 60 newly installed, 30 to remove and 1 not upgraded.
# Need to get 721 MB of archives.

#    $ apt list --upgradable
#    dell-service-meta/unknown,unknown 4.1 all [upgradable from: 4]
#    liboxideqtcore0/xenial-updates,xenial-security 1.21.5-0ubuntu0.16.04.1 amd64 [upgradable from: 1.13.6-0ubuntu1]
#    oxideqt-codecs/xenial-updates,xenial-security 1.21.5-0ubuntu0.16.04.1 amd64 [upgradable from: 1.13.6-0ubuntu1]

#    $ sudo apt upgrade
#    ...
#    The following packages will be upgraded:
#      dell-service-meta
#    Do you want to continue? [Y/n] 

#    $ sudo apt update
#    ...

#    $ sudo apt upgrade
#    ...
#    The following packages will be upgraded:
#      oem-wifi-intel-iwlwifi-lp1757035-4.4-dkms-dkms
#    Do you want to continue? [Y/n] 

# (yes, update-then-upgrade-then-update-then-upgrade,
# a.k.a., in pseudo-haskell, `(update >=> upgrade)` is not idempotent.)

#     $ sudo apt autoremove
#     The following packages will be REMOVED:
#       apt-xapian-index canonical-poke debconf-kde-data discover discover-data libappstreamqt1 libboost-log1.58.0 libboost-regex1.58.0 libboost-thread1.58.0 libclick-0.4-0
#       libcontent-hub0 libcuda1-370 libdebconf-kde1 libdiscover2 libgflags2v5 libgoogle-glog0v5 libkf5activitiesexperimentalstats1 libkf5gpgmepp5 libkf5prison1
#       libkwineffects7 libkwinglutils7 libkwinxrenderutils7 libleveldb1v5 liblibertine1 liblttng-ust-ctl2 liblttng-ust0 libmediainfo0v5 libmms0 libqapt3 libqapt3-runtime
#       libqca-qt5-2 libqca-qt5-2-plugins libthumbnailer-qt1.0 libtinyxml2-2v5 libubuntu-app-launch2 libubuntu-download-manager-client1 libubuntu-download-manager-common1
#       libudm-common1 libunity-api0 liburcu4 libxapian-1.3-5 libzen0v5 linux-headers-4.4.0-23 linux-headers-4.4.0-23-generic linux-image-4.4.0-23-generic
#       linux-image-extra-4.4.0-23-generic linux-signed-image-4.4.0-23-generic linux-tools-4.4.0-23 linux-tools-4.4.0-23-generic nvidia-370 nvidia-libopencl1-370
#       nvidia-opencl-icd-370 python3-xapian1.3 qml-module-qtwebkit qml-module-ubuntu-thumbnailer0.1 qtdeclarative5-ubuntu-thumbnailer0.1 qtdeclarative5-window-plugin
#       thumbnailer-service
#     0 upgraded, 0 newly installed, 58 to remove and 2 not upgraded.
#     After this operation, 327 MB disk space will be freed.
#     Do you want to continue? [Y/n] y

#     $ sudo apt update 
#     Hit:1 http://security.ubuntu.com/ubuntu xenial-security InRelease
#     Hit:2 http://archive.canonical.com/ubuntu xenial InRelease                                                                                                             
#     Ign:3 http://dl.google.com/linux/chrome/deb stable InRelease                                                                                                           
#     Hit:4 http://archive.ubuntu.com/ubuntu xenial InRelease                                                                                                                
#     Hit:5 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial InRelease                                         
#     Ign:6 http://dell.archive.canonical.com/updates xenial-dell-berlinetta-p-mlk InRelease                               
#     Hit:7 http://dl.google.com/linux/chrome/deb stable Release                                     
#     Hit:8 http://archive.ubuntu.com/ubuntu xenial-updates InRelease                               
#     Ign:9 http://dell.archive.canonical.com/updates xenial-dell-service InRelease
#     Hit:10 http://archive.ubuntu.com/ubuntu xenial-backports InRelease       
#     Ign:11 http://dell.archive.canonical.com/updates xenial-dell InRelease   
#     Hit:13 http://dell.archive.canonical.com/updates xenial-dell-berlinetta-p-mlk Release
#     Hit:14 http://dell.archive.canonical.com/updates xenial-dell-service Release
#     Hit:15 http://dell.archive.canonical.com/updates xenial-dell Release

#     $ sudo add-apt-repository ppa:kubuntu-ppa/backports
#     Backports of new versions of KDE Platform, Plasma and Applications as well as major KDE apps for Kubuntu.

#     $ time sudo apt install plasma-desktop
#

#     $ time sudo apt install kubuntu-desktop
#
#     The following additional packages will be installed:
#       accountwizard akonadi-backend-mysql akonadi-server akregator amarok amarok-common amarok-utils apport-kde apt-xapian-index apturl-kde ark baloo-utils cdparanoia
#       cdrdao cryptsetup debconf-kde-data distro-release-notifier dolphin dragonplayer ffmpegthumbs firefox fonts-dejavu fonts-lato freerdp-x11 gdebi-core gpgsm
#       gstreamer-qapt gstreamer1.0-nice gtk2-engines-oxygen gwenview ibus-qt4 icoutils k3b k3b-data kaccounts-integration kaccounts-providers kaddressbook kamera kate
#       kate-data kate5-data katepart kcalc kde-baseapps-bin kde-baseapps-data kde-config-gtk-style-preview kde-config-mailtransport kde-config-telepathy-accounts
#       kde-config-whoopsie kde-runtime kde-runtime-data kde-spectacle kde-telepathy kde-telepathy-approver kde-telepathy-auth-handler kde-telepathy-contact-list
#       kde-telepathy-data kde-telepathy-desktop-applets kde-telepathy-filetransfer-handler kde-telepathy-integration-module kde-telepathy-kaccounts kde-telepathy-kpeople
#       kde-telepathy-minimal kde-telepathy-send-file kde-telepathy-text-ui kdeconnect kdeconnect-plasma kdegraphics-strigi-analyzer kdegraphics-thumbnailers kdelibs-bin
#       kdelibs5-plugins kdemultimedia-kio-plugins kdenetwork-filesharing kdepim-addons kdepim-doc kdepim-runtime kdepim-themeeditors kdepimlibs-data kdepimlibs-kio-plugins
#       kdeplasma-addons-data kdesudo kdoctools kf5-kdepim-apps-libs-data kf5-messagelib-data kimageformat-plugins kio-audiocd kio-mtp kmail knotes konsole konsole-kpart
#       kontact konversation konversation-data korganizer krdc kross ksystemlog ktnef ktorrent ktorrent-data kubuntu-driver-manager kubuntu-notification-helper
#       kubuntu-settings-desktop kubuntu-web-shortcuts kwin-addons libaio1 libakonadi-kde4 libakonadi-kmime4 libakonadiprotocolinternals1 libass5 libavahi-gobject0
#       libavfilter-ffmpeg5 libavresample-ffmpeg2 libbaloocore4 libbaloofiles4 libbalooxapian4 libboost-thread1.58.0 libbs2b0 libc-ares2 libchm1 libdebconf-kde1
#       libdolphinvcs5 libdvdnav4 libdvdread4 libfakekey0 libfarstream-0.2-5 libflac++6v5 libflite1 libfreerdp-rail1.1 libgrantlee-textdocument5 libgssdp-1.0-3
#       libgupnp-1.0-4 libgupnp-igd-1.0-4 libhsqldb1.8.0-java libibus-qt1 libiso9660-8 libk3b6 libk3b6-extracodecs libkabc4 libkaccounts1 libkactivities6
#       libkatepartinterfaces4 libkcalcore4 libkcddb4 libkcmutils4 libkcompactdisc4 libkde3support4 libkdeclarative5 libkdesu5 libkdewebkit5 libkdnssd4 libkemoticons4
#       libkexiv2-11v5 libkexiv2-data libkf5akonadiagentbase5 libkf5akonadicalendar5 libkf5akonadicontact5 libkf5akonadicore-bin libkf5akonadicore5 libkf5akonadimime5
#       libkf5akonadinotes5 libkf5akonadiprivate5 libkf5akonadisearchdebug5 libkf5akonadisearchpim5 libkf5akonadiwidgets5 libkf5alarmcalendar5 libkf5baloowidgets-bin
#       libkf5baloowidgets5 libkf5calendarcore5 libkf5calendarsupport-data libkf5calendarsupport5 libkf5calendarutils5 libkf5contacts-data libkf5contacts5
#       libkf5eventviews-data libkf5eventviews5 libkf5followupreminder5 libkf5gapi-data libkf5gapicalendar5 libkf5gapicontacts5 libkf5gapicore5 libkf5gapitasks5
#       libkf5gpgmepp-pthread5 libkf5grantleetheme-plugins libkf5grantleetheme5 libkf5gravatar5 libkf5identitymanagement5 libkf5identitymanagement5abi1 libkf5imap5
#       libkf5incidenceeditor-bin libkf5incidenceeditor5 libkf5kaddressbookgrantlee5 libkf5kdcraw5 libkf5kdepimdbusinterfaces5 libkf5kdgantt2-5 libkf5kexiv2-15.0.0
#       libkf5kiogui5 libkf5kipi-bin libkf5kipi-data libkf5kipi31.0.0 libkf5kmanagesieve5 libkf5kontactinterface-data libkf5kontactinterface5 libkf5krosscore5
#       libkf5krossui5 libkf5ksieve-data libkf5ksieve5 libkf5ksieveui5 libkf5ldap5 libkf5libkdepim-data libkf5libkdepim-plugins libkf5libkdepim5 libkf5libkleo5
#       libkf5mailcommon-plugins libkf5mailcommon5 libkf5mailimporter5 libkf5mailtransport-data libkf5mailtransport5 libkf5mbox5 libkf5messagecomposer5 libkf5messagecore5
#       libkf5messagelist5 libkf5messageviewer5 libkf5mime5 libkf5modemmanagerqt6 libkf5pimcommon-plugins libkf5pimcommon5 libkf5pimtextedit5 libkf5pimtextedit5abi1
#       libkf5qgpgme5 libkf5sane-data libkf5sendlater5 libkf5syndication5 libkf5templateparser5 libkf5tnef5 libkf5unitconversion-data libkf5unitconversion5 libkf5webkit5
#       libkfile4 libkfilemetadata4 libkhtml5 libkidletime4 libkio5 libkjsapi4 libkjsembed4 libkldap4 libkmediaplayer4 libkmime4 libknewstuff2-4 libknewstuff3-4
#       libknotifyconfig4 libkntlm4 libkolab1 libkolabxml1v5 libkonq-common libkonq5-templates libkparts4 libkpimutils4 libkprintutils4 libkpty4 libkresources4
#       libkrosscore4 libksane-data libksane0 libktexteditor4 libktorrent-l10n libktorrent5 libktpcommoninternals9 libktplogger9 libktpmodels9 libktpotr9 libktpwidgets9
#       libkubuntu1 libkxmlrpcclient4 liblastfm1 libloudmouth1-0 libmad0 libmeanwhile1 libmission-control-plugins0 libmpcdec6 libmusicbrainz5cc2v5 libmygpo-qt1 libnice10
#       libnl-route-3-200 libntrack-qt4-1 libntrack0 libokularcore7 libopenconnect5 libopencv-core2.4v5 libopencv-imgproc2.4v5 libotr5 libpam-kwallet4 libparted-fs-resize0
#       libperl4-corelibs-perl libphonon4 libplasma3 libpolkit-qt-1-1 libpoppler-qt4-4 libpostproc-ffmpeg53 libpurple-bin libpurple0 libqapt3 libqapt3-runtime libqca-qt5-2
#       libqca-qt5-2-plugins libqca2 libqca2-plugin-ossl libqca2-plugins libqimageblitz4 libqjson0 libqmobipocket1 libqt4-designer libqt4-help libqt4-opengl
#       libqt4-qt3support libqt4-scripttools libqt4-test libqt5qml-graphicaleffects libqt5sql5-mysql libqt5xmlpatterns5 libqtassistantclient4 libqtscript4-core
#       libqtscript4-gui libqtscript4-network libqtscript4-sql libqtscript4-uitools libqtscript4-xml libqtwebkit4 libreoffice-base libreoffice-base-drivers
#       libreoffice-java-common libreoffice-kde libreoffice-sdbc-firebird libreoffice-sdbc-hsqldb libreoffice-style-oxygen libreoffice-style-tango libruby2.3
#       libservlet3.1-java libsodium18 libsolid4 libstoken1 libstreamanalyzer0v5 libstreams0v5 libswscale-ffmpeg3 libsyndication4 libtag-extras1 libtbb2
#       libtelepathy-logger-qt5 libtelepathy-logger3 libtelepathy-qt5-0 libthreadweaver4 libtomcrypt0 libtommath0 libvcdinfo0 libxapian-1.3-5 libxerces-c3.1
#       libxfreerdp-client1.1 libzephyr4 libzmq5 mysql-client-core-5.7 mysql-server-core-5.7 ntrack-module-libnl-0 ofono okular okular-extra-backends oxygen-icon-theme
#       oxygen5-icon-theme p7zip-full packagekit packagekit-tools partitionmanager phonon phonon-backend-gstreamer phonon-backend-gstreamer-common
#       phonon4qt5-backend-gstreamer pidgin-data pinentry-qt plasma-dataengines-addons plasma-discover plasma-discover-common plasma-nm plasma-runners-addons
#       plasma-scriptengine-javascript plasma-wallpapers-addons plasma-widgets-addons plymouth-theme-kubuntu-logo plymouth-theme-kubuntu-text print-manager python-qt4-dbus
#       python3-dbus.mainloop.pyqt5 python3-pykde4 python3-pyqt4 python3-pyqt5 python3-sip python3-xapian1.3 qapt-batch qapt-deb-installer qml-module-org-kde-kirigami
#       qml-module-org-kde-telepathy qml-module-qtquick-xmllistmodel qml-module-qtwebkit qt5-image-formats-plugins qtdeclarative5-xmllistmodel-plugin rake ruby
#       ruby-did-you-mean ruby-minitest ruby-net-telnet ruby-power-assert ruby-test-unit ruby2.3 rubygems-integration sddm sddm-theme-breeze signon-kwallet-extension
#       skanlite software-properties-kde sshfs telepathy-accounts-signon telepathy-gabble telepathy-haze telepathy-logger telepathy-mission-control-5 telepathy-ring
#       telepathy-salut ubuntu-release-upgrader-qt vcdimager xul-ext-ubufox
#
#     Suggested packages:
#       akonadi-backend-postgresql akonadi-backend-sqlite amarok-doc libqt4-sql-psql moodbar rar unrar | unrar-free dolphin-plugins fonts-lyx libterm-readline-gnu-perl
#       | libterm-readline-perl-perl k3b-extrathemes k3b-i18n normalize-audio sox movixmaker-2 kde-config-cddb djvulibre-bin finger telepathy-idle telepathy-rakia lame
#       clamav kleopatra procmail spamassassin | bogofilter | spambayes | bsfilter | crm114 gnokii krfb krosspython libdvdcss2 java-virtual-machine libhsqldb1.8.0-java-gcj
#       libotr5-bin libparted-dev libreoffice-gcj libreoffice-report-builder unixodbc libjtds-java libreoffice-mysql-connector | libmyodbc | libmysql-java
#       libreoffice-sdbc-postgresql | odbc-postgresql | libpg-java libsqliteodbc | tdsodbc | mdbtools konqueror kde-icons-oxygen oxygencursors tango-icon-theme xapian-tools
#       jovie texlive-binaries unrar p7zip-rar hfsplus hfsutils jfsutils reiser4progs reiserfsprogs xfsprogs phonon-backend-mplayer phonon-backend-vlc
#       gstreamer1.0-plugins-ugly pinentry-doc network-manager-openconnect network-manager-openvpn network-manager-vpnc python3-pyqt4-dbg python3-pyqt5-dbg xapian-doc ri
#       ruby-dev bundler skanlite-dbg
#
#     Recommended packages:
#       plasma-discover-updater kactivities system-config-printer
#
#     The following NEW packages will be installed:
#       accountwizard akonadi-backend-mysql akonadi-server akregator amarok amarok-common amarok-utils apport-kde apt-xapian-index apturl-kde ark baloo-utils cdparanoia
#       cdrdao cryptsetup debconf-kde-data distro-release-notifier dolphin dragonplayer ffmpegthumbs firefox fonts-dejavu fonts-lato freerdp-x11 gdebi-core gpgsm
#       gstreamer-qapt gstreamer1.0-nice gtk2-engines-oxygen gwenview ibus-qt4 icoutils k3b k3b-data kaccounts-integration kaccounts-providers kaddressbook kamera kate
#       kate-data kate5-data katepart kcalc kde-baseapps-bin kde-baseapps-data kde-config-gtk-style-preview kde-config-mailtransport kde-config-telepathy-accounts
#       kde-config-whoopsie kde-runtime kde-runtime-data kde-spectacle kde-telepathy kde-telepathy-approver kde-telepathy-auth-handler kde-telepathy-contact-list
#       kde-telepathy-data kde-telepathy-desktop-applets kde-telepathy-filetransfer-handler kde-telepathy-integration-module kde-telepathy-kaccounts kde-telepathy-kpeople
#       kde-telepathy-minimal kde-telepathy-send-file kde-telepathy-text-ui kdeconnect kdeconnect-plasma kdegraphics-strigi-analyzer kdegraphics-thumbnailers kdelibs-bin
#       kdelibs5-plugins kdemultimedia-kio-plugins kdenetwork-filesharing kdepim-addons kdepim-doc kdepim-runtime kdepim-themeeditors kdepimlibs-data kdepimlibs-kio-plugins
#       kdeplasma-addons-data kdesudo kdoctools kf5-kdepim-apps-libs-data kf5-messagelib-data kimageformat-plugins kio-audiocd kio-mtp kmail knotes konsole konsole-kpart
#       kontact konversation konversation-data korganizer krdc kross ksystemlog ktnef ktorrent ktorrent-data kubuntu-desktop kubuntu-driver-manager
#       kubuntu-notification-helper kubuntu-settings-desktop kubuntu-web-shortcuts kwin-addons libaio1 libakonadi-kde4 libakonadi-kmime4 libakonadiprotocolinternals1
#       libass5 libavahi-gobject0 libavfilter-ffmpeg5 libavresample-ffmpeg2 libbaloocore4 libbaloofiles4 libbalooxapian4 libboost-thread1.58.0 libbs2b0 libc-ares2 libchm1
#       libdebconf-kde1 libdolphinvcs5 libdvdnav4 libdvdread4 libfakekey0 libfarstream-0.2-5 libflac++6v5 libflite1 libfreerdp-rail1.1 libgrantlee-textdocument5
#       libgssdp-1.0-3 libgupnp-1.0-4 libgupnp-igd-1.0-4 libhsqldb1.8.0-java libibus-qt1 libiso9660-8 libk3b6 libk3b6-extracodecs libkabc4 libkaccounts1 libkactivities6
#       libkatepartinterfaces4 libkcalcore4 libkcddb4 libkcmutils4 libkcompactdisc4 libkde3support4 libkdeclarative5 libkdesu5 libkdewebkit5 libkdnssd4 libkemoticons4
#       libkexiv2-11v5 libkexiv2-data libkf5akonadiagentbase5 libkf5akonadicalendar5 libkf5akonadicontact5 libkf5akonadicore-bin libkf5akonadicore5 libkf5akonadimime5
#       libkf5akonadinotes5 libkf5akonadiprivate5 libkf5akonadisearchdebug5 libkf5akonadisearchpim5 libkf5akonadiwidgets5 libkf5alarmcalendar5 libkf5baloowidgets-bin
#       libkf5baloowidgets5 libkf5calendarcore5 libkf5calendarsupport-data libkf5calendarsupport5 libkf5calendarutils5 libkf5contacts-data libkf5contacts5
#       libkf5eventviews-data libkf5eventviews5 libkf5followupreminder5 libkf5gapi-data libkf5gapicalendar5 libkf5gapicontacts5 libkf5gapicore5 libkf5gapitasks5
#       libkf5gpgmepp-pthread5 libkf5grantleetheme-plugins libkf5grantleetheme5 libkf5gravatar5 libkf5identitymanagement5 libkf5identitymanagement5abi1 libkf5imap5
#       libkf5incidenceeditor-bin libkf5incidenceeditor5 libkf5kaddressbookgrantlee5 libkf5kdcraw5 libkf5kdepimdbusinterfaces5 libkf5kdgantt2-5 libkf5kexiv2-15.0.0
#       libkf5kiogui5 libkf5kipi-bin libkf5kipi-data libkf5kipi31.0.0 libkf5kmanagesieve5 libkf5kontactinterface-data libkf5kontactinterface5 libkf5krosscore5
#       libkf5krossui5 libkf5ksieve-data libkf5ksieve5 libkf5ksieveui5 libkf5ldap5 libkf5libkdepim-data libkf5libkdepim-plugins libkf5libkdepim5 libkf5libkleo5
#       libkf5mailcommon-plugins libkf5mailcommon5 libkf5mailimporter5 libkf5mailtransport-data libkf5mailtransport5 libkf5mbox5 libkf5messagecomposer5 libkf5messagecore5
#       libkf5messagelist5 libkf5messageviewer5 libkf5mime5 libkf5modemmanagerqt6 libkf5pimcommon-plugins libkf5pimcommon5 libkf5pimtextedit5 libkf5pimtextedit5abi1
#       libkf5qgpgme5 libkf5sane-data libkf5sendlater5 libkf5syndication5 libkf5templateparser5 libkf5tnef5 libkf5unitconversion-data libkf5unitconversion5 libkf5webkit5
#       libkfile4 libkfilemetadata4 libkhtml5 libkidletime4 libkio5 libkjsapi4 libkjsembed4 libkldap4 libkmediaplayer4 libkmime4 libknewstuff2-4 libknewstuff3-4
#       libknotifyconfig4 libkntlm4 libkolab1 libkolabxml1v5 libkonq-common libkonq5-templates libkparts4 libkpimutils4 libkprintutils4 libkpty4 libkresources4
#       libkrosscore4 libksane-data libksane0 libktexteditor4 libktorrent-l10n libktorrent5 libktpcommoninternals9 libktplogger9 libktpmodels9 libktpotr9 libktpwidgets9
#       libkubuntu1 libkxmlrpcclient4 liblastfm1 libloudmouth1-0 libmad0 libmeanwhile1 libmission-control-plugins0 libmpcdec6 libmusicbrainz5cc2v5 libmygpo-qt1 libnice10
#       libnl-route-3-200 libntrack-qt4-1 libntrack0 libokularcore7 libopenconnect5 libopencv-core2.4v5 libopencv-imgproc2.4v5 libotr5 libpam-kwallet4 libparted-fs-resize0
#       libperl4-corelibs-perl libphonon4 libplasma3 libpolkit-qt-1-1 libpoppler-qt4-4 libpostproc-ffmpeg53 libpurple-bin libpurple0 libqapt3 libqapt3-runtime libqca-qt5-2
#       libqca-qt5-2-plugins libqca2 libqca2-plugin-ossl libqca2-plugins libqimageblitz4 libqjson0 libqmobipocket1 libqt4-designer libqt4-help libqt4-opengl
#       libqt4-qt3support libqt4-scripttools libqt4-test libqt5qml-graphicaleffects libqt5sql5-mysql libqt5xmlpatterns5 libqtassistantclient4 libqtscript4-core
#       libqtscript4-gui libqtscript4-network libqtscript4-sql libqtscript4-uitools libqtscript4-xml libqtwebkit4 libreoffice-base libreoffice-base-drivers
#       libreoffice-java-common libreoffice-kde libreoffice-sdbc-firebird libreoffice-sdbc-hsqldb libreoffice-style-oxygen libreoffice-style-tango libruby2.3
#       libservlet3.1-java libsodium18 libsolid4 libstoken1 libstreamanalyzer0v5 libstreams0v5 libswscale-ffmpeg3 libsyndication4 libtag-extras1 libtbb2
#       libtelepathy-logger-qt5 libtelepathy-logger3 libtelepathy-qt5-0 libthreadweaver4 libtomcrypt0 libtommath0 libvcdinfo0 libxapian-1.3-5 libxerces-c3.1
#       libxfreerdp-client1.1 libzephyr4 libzmq5 mysql-client-core-5.7 mysql-server-core-5.7 ntrack-module-libnl-0 ofono okular okular-extra-backends oxygen-icon-theme
#       oxygen5-icon-theme p7zip-full packagekit packagekit-tools partitionmanager phonon phonon-backend-gstreamer phonon-backend-gstreamer-common
#       phonon4qt5-backend-gstreamer pidgin-data pinentry-qt plasma-dataengines-addons plasma-discover plasma-discover-common plasma-nm plasma-runners-addons
#       plasma-scriptengine-javascript plasma-wallpapers-addons plasma-widgets-addons plymouth-theme-kubuntu-logo plymouth-theme-kubuntu-text print-manager python-qt4-dbus
#       python3-dbus.mainloop.pyqt5 python3-pykde4 python3-pyqt4 python3-pyqt5 python3-sip python3-xapian1.3 qapt-batch qapt-deb-installer qml-module-org-kde-kirigami
#       qml-module-org-kde-telepathy qml-module-qtquick-xmllistmodel qml-module-qtwebkit qt5-image-formats-plugins qtdeclarative5-xmllistmodel-plugin rake ruby
#       ruby-did-you-mean ruby-minitest ruby-net-telnet ruby-power-assert ruby-test-unit ruby2.3 rubygems-integration sddm sddm-theme-breeze signon-kwallet-extension
#       skanlite software-properties-kde sshfs telepathy-accounts-signon telepathy-gabble telepathy-haze telepathy-logger telepathy-mission-control-5 telepathy-ring
#       telepathy-salut ubuntu-release-upgrader-qt vcdimager xul-ext-ubufox
#
#     0 upgraded, 430 newly installed, 0 to remove and 2 not upgraded.
#     After this operation, 970 MB of additional disk space will be used.
#     Do you want to continue? [Y/n] 
#
#     Get:1 http://archive.ubuntu.com/ubuntu xenial/main amd64 fonts-lato all 2.0-1 [2,693 kB]
#     Get:2 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libqt5sql5-mysql amd64 5.6.1+dfsg-3ubuntu1~xenialoverlay1~4+fix1 [70.7 kB]
#     Get:3 http://archive.ubuntu.com/ubuntu xenial/universe amd64 gtk2-engines-oxygen amd64 1.4.6-1ubuntu1 [398 kB]
#     Get:4 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libfakekey0 amd64 0.1-8.1 [6,182 B]
#     Get:5 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libgssdp-1.0-3 amd64 0.14.14-1ubuntu1 [28.1 kB]
#     Get:6 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libgupnp-1.0-4 amd64 0.20.16-1 [69.7 kB]
#     Get:7 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libgupnp-igd-1.0-4 amd64 0.2.4-1 [15.7 kB]
#     Get:8 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libmad0 amd64 0.15.1b-8ubuntu1 [71.5 kB]
#     Get:9 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libmpcdec6 amd64 2:0.1~r459-4.1build1 [32.0 kB]
#     Get:10 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libqjson0 amd64 0.8.1-3 [63.7 kB]
#     Get:11 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libqtscript4-core amd64 0.2.0-1 [976 kB]
#     Get:12 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libqtscript4-gui amd64 0.2.0-1 [4,178 kB]
#     Get:13 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 akonadi-backend-mysql all 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [23.9 kB]
#     Get:14 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5akonadiprivate5 amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [157 kB]
#     Get:15 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libqtscript4-network amd64 0.2.0-1 [419 kB]
#     Get:16 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libqtscript4-sql amd64 0.2.0-1 [194 kB]
#     Get:17 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libqtscript4-uitools amd64 0.2.0-1 [273 kB]
#     Get:18 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libqtscript4-xml amd64 0.2.0-1 [199 kB]
#     Get:19 http://archive.ubuntu.com/ubuntu xenial/universe amd64 qt5-image-formats-plugins amd64 5.5.1-2build1 [64.0 kB]
#     Get:20 http://archive.ubuntu.com/ubuntu xenial/main amd64 libaio1 amd64 0.3.110-2 [6,356 B]        
#     Get:21 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 mysql-client-core-5.7 amd64 5.7.23-0ubuntu0.16.04.1 [6,675 kB]
#     Get:22 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 akonadi-server amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [686 kB]
#     Get:23 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 mysql-server-core-5.7 amd64 5.7.23-0ubuntu0.16.04.1 [7,765 kB]
#     Get:24 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5ldap5 amd64 16.04.3-0ubuntu1~ubuntu16.04~ppa61 [85.1 kB]
#     Get:25 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kdepimlibs-kio-plugins amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [150 kB]
#     Get:26 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libgrantlee-textdocument5 amd64 5.0.0-0ubuntu4 [41.5 kB]
#     Get:27 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkf5pimtextedit5 amd64 15.12.3-0ubuntu1 [150 kB]
#     Get:28 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkf5identitymanagement5 amd64 15.12.3-0ubuntu1 [61.1 kB]
#     Get:29 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkf5gapi-data all 5.1.0-1ubuntu1 [31.5 kB]
#     Get:30 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkf5gapicore5 amd64 5.1.0-1ubuntu1 [47.2 kB]
#     Get:31 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkf5gapicalendar5 amd64 5.1.0-1ubuntu1 [59.0 kB]
#     Get:32 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkf5gapicontacts5 amd64 5.1.0-1ubuntu1 [60.1 kB]
#     Get:33 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkf5gapitasks5 amd64 5.1.0-1ubuntu1 [37.0 kB]
#     Get:34 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libxerces-c3.1 amd64 3.1.3+debian-1 [842 kB]
#     Get:35 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkolabxml1v5 amd64 1.1.2-0ubuntu3 [627 kB]
#     Get:36 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kdepimlibs-data all 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [83.0 kB]
#     Get:37 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkolab1 amd64 1.0.2-10ubuntu6 [254 kB]
#     Get:38 http://archive.ubuntu.com/ubuntu xenial/universe amd64 amarok-common all 2:2.8.0-0ubuntu9 [3,224 kB]
#     Get:39 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5akonadicore5 amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [674 kB]
#     Get:40 http://archive.ubuntu.com/ubuntu xenial/universe amd64 amarok-utils amd64 2:2.8.0-0ubuntu9 [44.9 kB]
#     Get:41 http://archive.ubuntu.com/ubuntu xenial/universe amd64 kate-data all 4:4.14.3-0ubuntu4 [1,461 kB]
#     Get:42 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libstreams0v5 amd64 0.7.8-2ubuntu1 [80.6 kB]
#     Get:43 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libstreamanalyzer0v5 amd64 0.7.8-2ubuntu1 [274 kB]
#     Get:44 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkatepartinterfaces4 amd64 4:4.14.3-0ubuntu4 [864 kB]
#     Get:45 http://archive.ubuntu.com/ubuntu xenial/universe amd64 katepart amd64 4:4.14.3-0ubuntu4 [62.6 kB]
#     Get:46 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libqtwebkit4 amd64 2.3.2-0ubuntu11 [9,034 kB]
#     Get:47 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5akonadiagentbase5 amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [121 kB]
#     Get:48 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5akonadiwidgets5 amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [229 kB]
#     Get:49 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5akonadicore-bin amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [22.7 kB]              
#     Get:50 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libphonon4 amd64 4:4.8.3-0ubuntu3 [151 kB]                                                               
#     Get:51 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libpolkit-qt-1-1 amd64 0.112.0-4 [53.2 kB]                                                               
#     Get:52 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libqca2 amd64 2.1.1-2ubuntu1 [305 kB]                                                                    
#     Get:53 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkactivities6 amd64 4:4.13.3-0ubuntu6 [34.6 kB]                                                        
#     Get:54 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkxmlrpcclient4 amd64 4:4.14.10-1ubuntu2 [28.8 kB]                                                     
#     Get:55 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libnl-route-3-200 amd64 3.2.27-1ubuntu0.16.04.1 [124 kB]                                             
#     Get:56 http://archive.ubuntu.com/ubuntu xenial/universe amd64 ntrack-module-libnl-0 amd64 016-1.3 [17.2 kB]                                                            
#     Get:57 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libntrack0 amd64 016-1.3 [7,340 B]                                                                       
#     Get:58 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libntrack-qt4-1 amd64 016-1.3 [6,904 B]                                                                  
#     Get:59 http://archive.ubuntu.com/ubuntu xenial/universe amd64 phonon-backend-gstreamer-common amd64 4:4.8.2-0ubuntu2 [11.0 kB]                                         
#     Get:60 http://archive.ubuntu.com/ubuntu xenial/universe amd64 phonon-backend-gstreamer amd64 4:4.8.2-0ubuntu2 [109 kB]                                                 
#     Get:61 http://archive.ubuntu.com/ubuntu xenial/universe amd64 phonon4qt5-backend-gstreamer amd64 4:4.8.2-0ubuntu2 [106 kB]                                             
#     Get:62 http://archive.ubuntu.com/ubuntu xenial/universe amd64 phonon amd64 4:4.8.3-0ubuntu3 [8,874 B]                                                                  
#     Get:63 http://archive.ubuntu.com/ubuntu xenial/universe amd64 liblastfm1 amd64 1.0.9-1 [175 kB]                                                                        
#     Get:64 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libloudmouth1-0 amd64 1.5.2-1build1 [48.8 kB]                                                            
#     Get:65 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libmygpo-qt1 amd64 1.0.7-0ubuntu2 [78.8 kB]                                                              
#     Get:66 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libtag-extras1 amd64 1.0.1-3build1 [18.7 kB]                                                             
#     Get:67 http://archive.ubuntu.com/ubuntu xenial/universe amd64 amarok amd64 2:2.8.0-0ubuntu9 [8,827 kB]                                                                 
#     Get:68 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5contacts-data all 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [33.5 kB]                  
#     Get:69 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5contacts5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [156 kB]                     
#     Get:70 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5mime5 amd64 16.04.3-0ubuntu1~ubuntu16.04~ppa61 [117 kB]                           
#     Get:71 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5akonadicontact5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [329 kB]               
#     Get:72 http://archive.ubuntu.com/ubuntu xenial/universe amd64 python3-sip amd64 4.17+dfsg-1build1 [70.5 kB]                                                            
#     Get:73 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 apport-kde all 2.20.1-0ubuntu2.18 [17.8 kB]                                                      
#     Get:74 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libxapian-1.3-5 amd64 1.3.4-0ubuntu6 [619 kB]                                                            
#     Get:75 http://archive.ubuntu.com/ubuntu xenial/universe amd64 python3-xapian1.3 amd64 1.3.4-0ubuntu1 [370 kB]                                                          
#     Get:76 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 apt-xapian-index all 0.47ubuntu8.4 [56.9 kB]                                                     
#     Get:77 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libqtassistantclient4 amd64 4.6.3-7 [12.8 kB]                                                            
#     Get:78 http://archive.ubuntu.com/ubuntu xenial/universe amd64 python3-pyqt4 amd64 4.11.4+dfsg-1build4 [2,322 kB]                                                       
#     Get:79 http://archive.ubuntu.com/ubuntu xenial/universe amd64 python3-pykde4 amd64 4:4.14.2-0ubuntu6 [2,476 kB]                                                        
#     Get:80 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5akonadimime5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [109 kB]                  
#     Get:81 http://archive.ubuntu.com/ubuntu xenial/universe amd64 kdesudo amd64 3.4.2.4+repack-2ubuntu4 [26.1 kB]                                                          
#     Get:82 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 libqapt3 amd64 3.0.2-0ubuntu1.2 [129 kB]                                                         
#     Get:83 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 libqapt3-runtime amd64 3.0.2-0ubuntu1.2 [60.7 kB]                                                
#     Get:84 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 qapt-batch amd64 3.0.2-0ubuntu1.2 [133 kB]                                                       
#     Get:85 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 software-properties-kde all 0.96.20.7 [19.5 kB]                                                  
#     Get:86 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 apturl-kde amd64 0.5.2ubuntu11.2 [5,348 B]                                                       
#     Get:87 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libakonadiprotocolinternals1 amd64 1.13.0-8ubuntu2 [70.8 kB]                                             
#     Get:88 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5calendarcore5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [265 kB]                 
#     Get:89 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libakonadi-kde4 amd64 4:4.14.10-1ubuntu2 [926 kB]                                                        
#     Get:90 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkmime4 amd64 4:4.14.10-1ubuntu2 [164 kB]                                                              
#     Get:91 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libakonadi-kmime4 amd64 4:4.14.10-1ubuntu2 [105 kB]                                                      
#     Get:92 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libbaloocore4 amd64 4:4.14.3-0ubuntu5 [33.2 kB]                                                          
#     Get:93 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libbalooxapian4 amd64 4:4.14.3-0ubuntu5 [29.0 kB]                                                        
#     Get:94 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libbaloofiles4 amd64 4:4.14.3-0ubuntu5 [52.1 kB]                                                         
#     Get:95 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkldap4 amd64 4:4.14.10-1ubuntu2 [84.0 kB]                                                             
#     Get:96 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkresources4 amd64 4:4.14.10-1ubuntu2 [70.8 kB]                                                        
#     Get:97 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkabc4 amd64 4:4.14.10-1ubuntu2 [306 kB]                                                               
#     Get:98 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkcalcore4 amd64 4:4.14.10-1ubuntu2 [265 kB]                                                           
#     Get:99 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libpoppler-qt4-4 amd64 0.41.0-0ubuntu1.8 [116 kB]                                                    
#     Get:100 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkfilemetadata4 amd64 4:4.14.2-0ubuntu2 [64.9 kB]                                                     
#     Get:101 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkpimutils4 amd64 4:4.14.10-1ubuntu2 [41.7 kB]                                                        
#     Get:102 http://archive.ubuntu.com/ubuntu xenial/universe amd64 baloo-utils amd64 4:4.14.3-0ubuntu5 [158 kB]                                                            
#     Get:103 http://archive.ubuntu.com/ubuntu xenial/universe amd64 cdparanoia amd64 3.10.2+debian-11 [36.2 kB]                                                             
#     Get:104 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 cryptsetup amd64 2:1.6.6-5ubuntu2.1 [123 kB]                                                        
#     Get:105 http://archive.ubuntu.com/ubuntu xenial/universe amd64 debconf-kde-data all 1.0.2-0ubuntu1 [15.3 kB]                                                           
#     Get:106 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 ubuntu-release-upgrader-qt all 1:16.04.25 [5,758 B]                                             
#     Get:107 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libass5 amd64 0.13.1-1 [82.6 kB]                                                                        
#     Get:108 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 libavresample-ffmpeg2 amd64 7:2.8.15-0ubuntu0.16.04.1 [52.0 kB]                                 
#     Get:109 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libbs2b0 amd64 3.1.0+dfsg-2.2 [10.5 kB]                                                                 
#     Get:110 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libflite1 amd64 2.0.0-release-1 [12.8 MB]                                                               
#     Get:111 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5calendarutils5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [135 kB]               
#     Get:112 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5mailtransport-data all 16.04.3-0ubuntu1~ubuntu16.04~ppa61 [6,300 B]              
#     Get:113 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5mailtransport5 amd64 16.04.3-0ubuntu1~ubuntu16.04~ppa61 [137 kB]                 
#     Get:114 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libtbb2 amd64 4.4~20151115-0ubuntu3 [111 kB]                                                            
#     Get:115 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 libopencv-core2.4v5 amd64 2.4.9.1+dfsg-1.5ubuntu1.1 [674 kB]                                    
#     Get:116 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 libopencv-imgproc2.4v5 amd64 2.4.9.1+dfsg-1.5ubuntu1.1 [632 kB]                                 
#     Get:117 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 libpostproc-ffmpeg53 amd64 7:2.8.15-0ubuntu0.16.04.1 [48.9 kB]                                  
#     Get:118 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 libswscale-ffmpeg3 amd64 7:2.8.15-0ubuntu0.16.04.1 [146 kB]                                     
#     Get:119 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libsodium18 amd64 1.0.8-5 [144 kB]                                                                      
#     Get:120 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libzmq5 amd64 4.1.4-7 [149 kB]                                                                          
#     Get:121 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 libavfilter-ffmpeg5 amd64 7:2.8.15-0ubuntu0.16.04.1 [530 kB]                                    
#     Get:122 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5akonadicalendar5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [258 kB]             
#     Get:123 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 firefox amd64 62.0.3+build1-0ubuntu0.16.04.2 [44.7 MB]                                              
#     Get:124 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5akonadinotes5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [44.4 kB]               
#     Get:125 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5alarmcalendar5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [118 kB]               
#     Get:126 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5imap5 amd64 16.04.3-0ubuntu1~ubuntu16.04~ppa61 [176 kB]                          
#     Get:127 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5mbox5 amd64 16.04.3-0ubuntu1~ubuntu16.04~ppa61 [22.1 kB]                         
#     Get:128 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libqt5xmlpatterns5 amd64 5.6.1-2build1~~xenialoverlay1~4 [950 kB]                      
#     Get:129 http://archive.ubuntu.com/ubuntu xenial/universe amd64 fonts-dejavu all 2.35-1 [3,184 B]                                                                       
#     Get:130 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libfreerdp-rail1.1 amd64 1.1.0~git20140921.1.440916e+dfsg1-5ubuntu1.2 [16.3 kB]                     
#     Get:131 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libxfreerdp-client1.1 amd64 1.1.0~git20140921.1.440916e+dfsg1-5ubuntu1.2 [58.1 kB]                  
#     Get:132 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 freerdp-x11 amd64 1.1.0~git20140921.1.440916e+dfsg1-5ubuntu1.2 [16.5 kB]                            
#     Get:133 http://archive.ubuntu.com/ubuntu xenial/main amd64 gdebi-core all 0.9.5.7ubuntu1 [9,716 B]                                                                     
#     Get:134 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 gpgsm amd64 2.1.11-6ubuntu2.1 [204 kB]                                                          
#     Get:135 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 gstreamer-qapt amd64 3.0.2-0ubuntu1.2 [140 kB]                                                  
#     Get:136 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libnice10 amd64 0.1.13-0ubuntu2 [131 kB]                                                                
#     Get:137 http://archive.ubuntu.com/ubuntu xenial/universe amd64 gstreamer1.0-nice amd64 0.1.13-0ubuntu2 [18.4 kB]                                                       
#     Get:138 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libibus-qt1 amd64 1.3.2-2build1 [90.4 kB]                                                               
#     Get:139 http://archive.ubuntu.com/ubuntu xenial/universe amd64 ibus-qt4 amd64 1.3.2-2build1 [31.9 kB]                                                                  
#     Get:140 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kdepim-runtime amd64 4:16.04.3-0ubuntu3~ubuntu16.04~ppa61 [1,600 kB]                   
#     Get:141 http://archive.ubuntu.com/ubuntu xenial/universe amd64 icoutils amd64 0.31.0-3 [56.7 kB]                                                                       
#     Get:142 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libdvdread4 amd64 5.0.3-1 [49.6 kB]                                                                     
#     Get:143 http://archive.ubuntu.com/ubuntu xenial/main amd64 libflac++6v5 amd64 1.3.1-4 [27.6 kB]                                                                        
#     Get:144 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libmusicbrainz5cc2v5 amd64 5.1.0+git20150707-5 [98.1 kB]                                                
#     Get:145 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libk3b6 amd64 2.0.3-0ubuntu5 [764 kB]                                                                   
#     Get:146 http://archive.ubuntu.com/ubuntu xenial/universe amd64 k3b-data all 2.0.3-0ubuntu5 [2,204 kB]                                                                  
#     Get:147 http://archive.ubuntu.com/ubuntu xenial/universe amd64 cdrdao amd64 1:1.2.3-2 [481 kB]                                                                         
#     Get:148 http://archive.ubuntu.com/ubuntu xenial/universe amd64 k3b amd64 2.0.3-0ubuntu5 [563 kB]                                                                       
#     Get:149 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libtelepathy-qt5-0 amd64 0.9.6.1-0ubuntu3 [1,325 kB]                                                    
#     Get:150 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libtelepathy-logger3 amd64 0.8.2-1 [66.0 kB]                                                            
#     Get:151 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libtelepathy-logger-qt5 amd64 15.04.0-0ubuntu1 [49.0 kB]                                                
#     Get:152 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libmission-control-plugins0 amd64 1:5.16.3-1ubuntu6 [17.6 kB]                                           
#     Get:153 http://archive.ubuntu.com/ubuntu xenial/universe amd64 telepathy-accounts-signon amd64 1.0-1 [10.3 kB]                                                         
#     Get:154 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libqca-qt5-2 amd64 2.1.1-0ubuntu2 [338 kB]                                                              
#     Get:155 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libotr5 amd64 4.1.1-1 [75.2 kB]                                                                         
#     Get:156 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libavahi-gobject0 amd64 0.6.32~rc+dfsg-1ubuntu2.2 [16.9 kB]                                         
#     Get:157 http://archive.ubuntu.com/ubuntu xenial/universe amd64 telepathy-salut amd64 0.8.1-5ubuntu1 [337 kB]                                                           
#     Get:158 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libc-ares2 amd64 1.10.0-3ubuntu0.2 [34.1 kB]                                                        
#     Get:159 http://archive.ubuntu.com/ubuntu xenial/universe amd64 ofono amd64 1.17.bzr6912+16.04.20160314.3-0ubuntu1 [543 kB]                                             
#     Get:160 http://archive.ubuntu.com/ubuntu xenial/universe amd64 telepathy-ring amd64 2.1.0-1ubuntu1 [107 kB]                                                            
#     Get:161 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 pidgin-data all 1:2.10.12-0ubuntu5.2 [4,657 kB]                                                 
#     Get:162 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libfarstream-0.2-5 amd64 0.2.7-0ubuntu1 [192 kB]                                                        
#     Get:163 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libmeanwhile1 amd64 1.0.2-7 [72.4 kB]                                                                   
#     Get:164 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libzephyr4 amd64 3.1.2-1build1 [26.9 kB]                                                                
#     Get:165 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 libpurple0 amd64 1:2.10.12-0ubuntu5.2 [1,322 kB]                                                
#     Get:166 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5pimtextedit5abi1 amd64 16.04.3-0ubuntu2~ubuntu16.04~ppa61 [152 kB]               
#     Get:167 http://archive.ubuntu.com/ubuntu xenial/universe amd64 telepathy-haze amd64 0.8.0-2 [62.8 kB]                                                                  
#     Get:168 http://archive.ubuntu.com/ubuntu xenial/universe amd64 telepathy-gabble amd64 0.18.3-2build1 [566 kB]                                                          
#     Get:169 http://archive.ubuntu.com/ubuntu xenial/universe amd64 telepathy-mission-control-5 amd64 1:5.16.3-1ubuntu6 [162 kB]                                            
#     Get:170 http://archive.ubuntu.com/ubuntu xenial/universe amd64 kde-telepathy-minimal all 15.04.20ubuntu1 [2,874 B]                                                     
#     Get:171 http://archive.ubuntu.com/ubuntu xenial/universe amd64 kde-telepathy all 15.04.20ubuntu1 [1,988 B]                                                             
#     Get:172 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libqca-qt5-2-plugins amd64 2.1.1-0ubuntu2 [217 kB]                                                      
#     Get:173 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5identitymanagement5abi1 amd64 16.04.3-0ubuntu2~ubuntu16.04~ppa61 [62.0 kB]       
#     Get:174 http://archive.ubuntu.com/ubuntu xenial/universe amd64 sshfs amd64 2.5-1ubuntu1 [41.7 kB]                                                                      
#     Get:175 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libktorrent5 amd64 1.3.1-5build2 [528 kB]                                                               
#     Get:176 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libsyndication4 amd64 4:4.14.10-1ubuntu2 [191 kB]                                                       
#     Get:177 http://archive.ubuntu.com/ubuntu xenial/universe amd64 ktorrent-data all 4.3.1-4 [1,411 kB]                                                                    
#     Get:178 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5krosscore5 amd64 5.36.0-0ubuntu1~ubuntu16.04~ppa1 [51.2 kB]                      
#     Get:179 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libktorrent-l10n all 1.3.1-5build2 [72.2 kB]                                                            
#     Get:180 http://archive.ubuntu.com/ubuntu xenial/universe amd64 ktorrent amd64 4.3.1-4 [975 kB]                                                                         
#     Get:181 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkexiv2-data all 4:15.08.2-0ubuntu1 [62.2 kB]                                                         
#     Get:182 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkexiv2-11v5 amd64 4:15.08.2-0ubuntu1 [191 kB]                                                        
#     Get:183 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5libkdepim-data all 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [8,622 B]                
#     Get:184 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libqimageblitz4 amd64 1:0.0.6-4build1 [51.8 kB]                                                         
#     Get:185 http://archive.ubuntu.com/ubuntu xenial/universe amd64 kubuntu-desktop amd64 1.338 [3,902 B]                                                                   
#     Get:186 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libdebconf-kde1 amd64 1.0.2-0ubuntu1 [41.5 kB]                                                          
#     Get:187 http://archive.ubuntu.com/ubuntu xenial/universe amd64 kubuntu-driver-manager amd64 15.10ubuntu3 [63.2 kB]                                                     
#     Get:188 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libkubuntu1 amd64 15.04ubuntu2 [26.6 kB]                                                                
#     Get:189 http://archive.ubuntu.com/ubuntu xenial/universe amd64 kubuntu-settings-desktop all 1:16.04ubuntu2 [2,381 kB]                                                  
#     Get:190 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5akonadisearchpim5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [37.4 kB]           
#     Get:191 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5libkdepim5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [283 kB]                   
#     Get:192 http://archive.ubuntu.com/ubuntu xenial/universe amd64 kubuntu-web-shortcuts all 15.04ubuntu1 [6,032 B]                                                        
#     Get:193 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libchm1 amd64 2:0.40a-3 [24.8 kB]                                                                       
#     Get:194 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libdvdnav4 amd64 5.0.3-1 [37.3 kB]                                                                      
#     Get:195 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libservlet3.1-java all 8.0.32-1ubuntu1.8 [391 kB]                                                   
#     Get:196 http://archive.ubuntu.com/ubuntu xenial/main amd64 libhsqldb1.8.0-java all 1.8.0.10+dfsg-6 [724 kB]                                                            
#     Get:197 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libiso9660-8 amd64 0.83-4.2ubuntu1 [18.4 kB]                                                            
#     Get:198 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libk3b6-extracodecs amd64 2.0.3-0ubuntu5 [50.8 kB]                                                      
#     Get:199 http://archive.ubuntu.com/ubuntu xenial/main amd64 libtommath0 amd64 0.42.0-1.2 [41.8 kB]                                                                      
#     Get:200 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 libtomcrypt0 amd64 1.17-7ubuntu0.1 [286 kB]                                                     
#     Get:201 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libstoken1 amd64 0.90-1 [25.6 kB]                                                                       
#     Get:202 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libopenconnect5 amd64 7.06-2build2 [85.9 kB]                                                            
#     Get:203 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libparted-fs-resize0 amd64 3.2-15ubuntu0.1 [46.4 kB]                                                
#     Get:204 http://archive.ubuntu.com/ubuntu xenial/main amd64 libperl4-corelibs-perl all 0.003-2 [37.3 kB]                                                                
#     Get:205 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 libpurple-bin all 1:2.10.12-0ubuntu5.2 [15.9 kB]                                                
#     Get:206 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libqca2-plugins amd64 2.1.1-2ubuntu1 [186 kB]                                                           
#     Get:207 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libqca2-plugin-ossl amd64 2.1.1-2ubuntu1 [4,278 B]                                                      
#     Get:208 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libreoffice-base-drivers amd64 1:5.1.6~rc2-0ubuntu1~xenial4 [510 kB]                                
#     Get:209 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5libkdepim-plugins amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [24.1 kB]           
#     Get:210 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libreoffice-base amd64 1:5.1.6~rc2-0ubuntu1~xenial4 [1,519 kB]                                      
#     Get:211 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libreoffice-java-common all 1:5.1.6~rc2-0ubuntu1~xenial4 [1,942 kB]                                 
#     Get:212 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 accountwizard amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [395 kB]                      
#     Get:213 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 libreoffice-kde amd64 1:5.1.6~rc2-0ubuntu1~xenial4 [86.0 kB]                                    
#     Get:214 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libreoffice-sdbc-firebird amd64 1:5.1.6~rc2-0ubuntu1~xenial4 [3,032 B]                              
#     Get:215 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libreoffice-sdbc-hsqldb amd64 1:5.1.6~rc2-0ubuntu1~xenial4 [107 kB]                                 
#     Get:216 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libreoffice-style-tango all 1:5.1.6~rc2-0ubuntu1~xenial4 [1,373 kB]                                 
#     Get:217 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 libreoffice-style-oxygen all 1:5.1.6~rc2-0ubuntu1~xenial4 [1,335 kB]                            
#     Get:218 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libvcdinfo0 amd64 0.7.24+dfsg-0.2 [90.7 kB]                                                             
#     Get:219 http://archive.ubuntu.com/ubuntu xenial/universe amd64 p7zip-full amd64 9.20.1~dfsg.1-4.2 [919 kB]                                                             
#     Get:220 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 partitionmanager amd64 1.2.1-0ubuntu1.1 [1,924 kB]                                              
#     Get:221 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5grantleetheme-plugins amd64 16.04.3-1ubuntu1~ubuntu16.04~ppa61 [12.1 kB]         
#     Get:222 http://archive.ubuntu.com/ubuntu xenial/universe amd64 pinentry-qt amd64 0.9.7-3 [43.8 kB]                                                                     
#     Get:223 http://archive.ubuntu.com/ubuntu xenial/universe amd64 plymouth-theme-kubuntu-logo all 1:16.04ubuntu2 [37.2 kB]                                                
#     Get:224 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5grantleetheme5 amd64 16.04.3-1ubuntu1~ubuntu16.04~ppa61 [26.7 kB]                
#     Get:225 http://archive.ubuntu.com/ubuntu xenial/universe amd64 plymouth-theme-kubuntu-text all 1:16.04ubuntu2 [4,350 B]                                                
#     Get:226 http://archive.ubuntu.com/ubuntu xenial/universe amd64 python-qt4-dbus amd64 4.11.4+dfsg-1build4 [12.6 kB]                                                     
#     Get:227 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 qapt-deb-installer amd64 3.0.2-0ubuntu1.2 [108 kB]                                              
#     Get:228 http://archive.ubuntu.com/ubuntu xenial/main amd64 rubygems-integration all 1.10 [4,966 B]                                                                     
#     Get:229 http://archive.ubuntu.com/ubuntu xenial/main amd64 ruby-did-you-mean all 1.0.0-2 [8,390 B]                                                                     
#     Get:230 http://archive.ubuntu.com/ubuntu xenial/main amd64 ruby-minitest all 5.8.4-2 [36.6 kB]                                                                         
#     Get:231 http://archive.ubuntu.com/ubuntu xenial/main amd64 ruby-net-telnet all 0.1.1-2 [12.6 kB]                                                                       
#     Get:232 http://archive.ubuntu.com/ubuntu xenial/main amd64 ruby-power-assert all 0.2.7-1 [7,668 B]                                                                     
#     Get:233 http://archive.ubuntu.com/ubuntu xenial/main amd64 ruby-test-unit all 3.1.7-2 [60.3 kB]                                                                        
#     Get:234 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5kiogui5 amd64 5.36.0-0ubuntu1.1~ubuntu16.04~ppa1 [25.0 kB]                       
#     Get:235 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libruby2.3 amd64 2.3.1-2~16.04.10 [2,960 kB]                                                        
#     Get:236 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5kontactinterface-data all 16.04.3-0ubuntu1~ubuntu16.04~ppa61 [4,012 B]           
#     Get:237 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5kontactinterface5 amd64 16.04.3-0ubuntu1~ubuntu16.04~ppa61 [32.5 kB]             
#     Get:238 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 ruby2.3 amd64 2.3.1-2~16.04.10 [41.0 kB]                                                            
#     Get:239 http://archive.ubuntu.com/ubuntu xenial/main amd64 ruby all 1:2.3.0+1 [5,530 B]                                                                                
#     Get:240 http://archive.ubuntu.com/ubuntu xenial/main amd64 rake all 10.5.0-2 [48.2 kB]                                                                                 
#     Get:241 http://archive.ubuntu.com/ubuntu xenial/universe amd64 sddm amd64 0.13.0-1ubuntu5 [270 kB]                                                                     
#     Get:242 http://archive.ubuntu.com/ubuntu xenial/universe amd64 telepathy-logger amd64 0.8.2-1 [6,100 B]                                                                
#     Get:243 http://archive.ubuntu.com/ubuntu xenial/universe amd64 vcdimager amd64 0.7.24+dfsg-0.2 [169 kB]                                                                
#     Get:244 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 xul-ext-ubufox all 3.4-0ubuntu0.16.04.2 [3,302 B]                                                   
#     Get:245 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kf5-messagelib-data all 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [3,969 kB]                
#     Get:246 http://archive.ubuntu.com/ubuntu xenial/universe amd64 kde-config-whoopsie amd64 15.10ubuntu2 [17.0 kB]                                                        
#     Get:247 http://archive.ubuntu.com/ubuntu xenial/universe amd64 kio-mtp amd64 0.75+git20140304-2 [37.1 kB]                                                              
#     Get:248 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libksane0 amd64 4:15.08.2-0ubuntu1 [84.4 kB]                                                            
#     Get:249 http://archive.ubuntu.com/ubuntu xenial/universe amd64 skanlite amd64 1.1-0ubuntu1 [2,499 kB]                                                                  
#     Get:250 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5gpgmepp-pthread5 amd64 16.04.3-0ubuntu1~ubuntu16.04~ppa61 [95.2 kB]              
#     Get:251 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5pimcommon5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [462 kB]                   
#     Get:252 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5pimcommon-plugins amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [10.3 kB]           
#     Get:253 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5gravatar5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [29.9 kB]                   
#     Get:254 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kf5-kdepim-apps-libs-data all 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [3,342 B]           
#     Get:255 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5qgpgme5 amd64 16.04.3-0ubuntu1~ubuntu16.04~ppa61 [13.5 kB]                       
#     Get:256 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5libkleo5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [358 kB]                     
#     Get:257 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5kaddressbookgrantlee5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [52.7 kB]       
#     Get:258 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5messagecore5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [82.5 kB]                
#     Get:259 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5webkit5 amd64 5.36.0-0ubuntu1~ubuntu16.04~ppa1 [54.7 kB]                         
#     Get:260 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5messageviewer5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [502 kB]               
#     Get:261 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5syndication5 amd64 16.04.3-0ubuntu1~ubuntu16.04~ppa61 [167 kB]                   
#     Get:262 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 akregator amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [654 kB]                          
#     Get:263 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-runtime-data all 4:16.04.3-0ubuntu2~ubuntu16.04~ppa61 [6,965 kB]                   
#     Get:264 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkcmutils4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [162 kB]                      
#     Get:265 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libsolid4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [341 kB]                         
#     Get:266 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkio5 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [932 kB]                           
#     Get:267 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libknewstuff3-4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [230 kB]                   
#     Get:268 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkparts4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [189 kB]                        
#     Get:269 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libktexteditor4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [162 kB]                   
#     Get:270 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkjsapi4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [332 kB]                        
#     Get:271 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkjsembed4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [374 kB]                      
#     Get:272 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkrosscore4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [122 kB]                     
#     Get:273 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kdelibs-bin amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [232 kB]                       
#     Get:274 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kdoctools amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [242 kB]                         
#     Get:275 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkpty4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [98.0 kB]                         
#     Get:276 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libqt4-designer amd64 4:4.8.7+dfsg-7ubuntu1~xenialoverlay1~1 [3,628 kB]                
#     Get:277 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libqt4-qt3support amd64 4:4.8.7+dfsg-7ubuntu1~xenialoverlay1~1 [1,050 kB]              
#     Get:278 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkde3support4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [381 kB]                   
#     Get:279 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libqt4-opengl amd64 4:4.8.7+dfsg-7ubuntu1~xenialoverlay1~1 [300 kB]                    
#     Get:280 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkdewebkit5 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [128 kB]                     
#     Get:281 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkemoticons4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [107 kB]                    
#     Get:282 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkfile4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [289 kB]                         
#     Get:283 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkhtml5 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [2,093 kB]                       
#     Get:284 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkntlm4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [93.8 kB]                        
#     Get:285 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kdelibs5-plugins amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [1,049 kB]                
#     Get:286 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 oxygen-icon-theme all 5:5.36.0-0ubuntu1~ubuntu16.04~ppa1 [31.1 MB]                     
#     Get:287 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkdnssd4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [132 kB]                        
#     Get:288 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libthreadweaver4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [110 kB]                  
#     Get:289 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libplasma3 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [994 kB]                        
#     Get:290 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 plasma-scriptengine-javascript amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa61 [426 kB]     
#     Get:291 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkdeclarative5 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [104 kB]                  
#     Get:292 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkdesu5 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [118 kB]                         
#     Get:293 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkmediaplayer4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [94.4 kB]                 
#     Get:294 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libknotifyconfig4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [105 kB]                 
#     Get:295 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-runtime amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa61 [1,932 kB]                      
#     Get:296 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 python3-pyqt5 amd64 5.5.1+dfsg-3ubuntu5~xenialoverlay11~1 [2,139 kB]                   
#     Get:297 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 konsole-kpart amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa62 [348 kB]                      
#     Get:298 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 konsole amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa62 [143 kB]                            
#     Get:299 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libqt4-help amd64 4:4.8.7+dfsg-7ubuntu1~xenialoverlay1~1 [207 kB]                      
#     Get:300 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libqt4-scripttools amd64 4:4.8.7+dfsg-7ubuntu1~xenialoverlay1~1 [223 kB]               
#     Get:301 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libqt4-test amd64 4:4.8.7+dfsg-7ubuntu1~xenialoverlay1~1 [61.0 kB]                     
#     Get:302 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkidletime4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [104 kB]                     
#     Get:303 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libknewstuff2-4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [204 kB]                   
#     Get:304 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkprintutils4 amd64 4:4.14.22-0ubuntu2.2~ubuntu16.04~ppa1 [93.6 kB]                  
#     Get:305 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 ark amd64 4:16.04.3a-0ubuntu2.1~ubuntu16.04~ppa1 [453 kB]                              
#     Get:306 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libqmobipocket1 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa62 [16.7 kB]                   
#     Get:307 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 distro-release-notifier amd64 0.0+git20180709-0ubuntu1~ubuntu16.04~ppa1 [14.4 kB]      
#     Get:308 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5baloowidgets-bin amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [13.5 kB]            
#     Get:309 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libdolphinvcs5 amd64 4:16.04.3-0ubuntu2.1~ubuntu16.04~ppa1 [75.3 kB]                   
#     Get:310 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5baloowidgets5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [66.0 kB]               
#     Get:311 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 dolphin amd64 4:16.04.3-0ubuntu2.1~ubuntu16.04~ppa1 [1,032 kB]                         
#     Get:312 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 dragonplayer amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [456 kB]                       
#     Get:313 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 ffmpegthumbs amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [18.8 kB]                      
#     Get:314 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5kdcraw5 amd64 16.04.3-0ubuntu1~ubuntu16.04~ppa61 [33.7 kB]                       
#     Get:315 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5kexiv2-15.0.0 amd64 16.04.3-0ubuntu1~ubuntu16.04~ppa52 [127 kB]                  
#     Get:316 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5kipi-data all 16.04.3-0ubuntu2~ubuntu16.04~ppa1 [31.9 kB]                        
#     Get:317 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5kipi31.0.0 amd64 16.04.3-0ubuntu2~ubuntu16.04~ppa1 [69.9 kB]                     
#     Get:318 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5kipi-bin amd64 16.04.3-0ubuntu2~ubuntu16.04~ppa1 [54.0 kB]                       
#     Get:319 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 gwenview amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [2,856 kB]                         
#     Get:320 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkcompactdisc4 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa62 [50.2 kB]                  
#     Get:321 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkcddb4 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa62 [125 kB]                          
#     Get:322 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkaccounts1 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [18.5 kB]                     
#     Get:323 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 signon-kwallet-extension amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [15.5 kB]          
#     Get:324 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kaccounts-integration amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [63.5 kB]             
#     Get:325 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kaccounts-providers amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [24.7 kB]               
#     Get:326 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5akonadisearchdebug5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [24.4 kB]         
#     Get:327 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kaddressbook amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [335 kB]                       
#     Get:328 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kamera amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [60.0 kB]                            
#     Get:329 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kate5-data all 4:16.04.3-0ubuntu1~ubuntu16.04~ppa63 [438 kB]                           
#     Get:330 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kate amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa63 [1,610 kB]                             
#     Get:331 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kcalc amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [153 kB]                              
#     Get:332 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-baseapps-data all 4:16.04.3-0ubuntu1~ubuntu16.04~ppa63 [264 kB]                    
#     Get:333 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-baseapps-bin amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa63 [369 kB]                   
#     Get:334 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-config-gtk-style-preview amd64 4:5.8.9-0ubuntu1~ubuntu16.04~ppa1 [10.6 kB]         
#     Get:335 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-config-mailtransport amd64 16.04.3-0ubuntu1~ubuntu16.04~ppa61 [8,824 B]            
#     Get:336 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-telepathy-data all 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [171 kB]                   
#     Get:337 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-telepathy-kaccounts amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [26.4 kB]           
#     Get:338 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libktpcommoninternals9 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [126 kB]             
#     Get:339 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libktplogger9 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [50.3 kB]                     
#     Get:340 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-telepathy-kpeople amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [49.9 kB]             
#     Get:341 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-config-telepathy-accounts amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [145 kB]      
#     Get:342 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-spectacle amd64 16.04.3-0ubuntu1~ubuntu16.04~ppa61 [1,034 kB]                      
#     Get:343 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libktpmodels9 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [84.7 kB]                     
#     Get:344 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libktpwidgets9 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [73.4 kB]                    
#     Get:345 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 qml-module-org-kde-telepathy amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [74.7 kB]      
#     Get:346 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-telepathy-desktop-applets amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [24.5 kB]     
#     Get:347 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-telepathy-filetransfer-handler amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [38.0 kB]
#     Get:348 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-telepathy-approver amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [36.1 kB]            
#     Get:349 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-telepathy-auth-handler amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [66.6 kB]        
#     Get:350 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-telepathy-contact-list amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [133 kB]         
#     Get:351 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-telepathy-integration-module amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [95.6 kB]  
#     Get:352 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libktpotr9 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [128 kB]                         
#     Get:353 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-telepathy-text-ui amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [520 kB]              
#     Get:354 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kde-telepathy-send-file amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [21.3 kB]           
#     Get:355 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kdeconnect amd64 1.0.3-0ubuntu1~ubuntu16.04~ppa1 [389 kB]                              
#     Get:356 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kdeconnect-plasma amd64 1.0.3-0ubuntu1~ubuntu16.04~ppa1 [5,832 B]                      
#     Get:357 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kdegraphics-strigi-analyzer amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [12.8 kB]       
#     Get:358 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kdegraphics-thumbnailers amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [33.8 kB]          
#     Get:359 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kdenetwork-filesharing amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [27.3 kB]            
#     Get:360 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5calendarsupport-data all 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [3,898 B]          
#     Get:361 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5kdepimdbusinterfaces5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [22.5 kB]       
#     Get:362 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5calendarsupport5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [248 kB]             
#     Get:363 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5eventviews-data all 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [3,634 B]               
#     Get:364 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5kdgantt2-5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [90.3 kB]                  
#     Get:365 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5eventviews5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [395 kB]                  
#     Get:366 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5incidenceeditor5 amd64 16.04.3-0ubuntu1~ubuntu16.04~ppa62 [332 kB]               
#     Get:367 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5incidenceeditor-bin amd64 16.04.3-0ubuntu1~ubuntu16.04~ppa62 [9,926 B]           
#     Get:368 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5mailimporter5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [113 kB]                
#     Get:369 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5followupreminder5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [12.1 kB]           
#     Get:370 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5sendlater5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [23.8 kB]                  
#     Get:371 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5templateparser5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [102 kB]              
#     Get:372 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5messagecomposer5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [345 kB]             
#     Get:373 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5mailcommon5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [458 kB]                  
#     Get:374 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5mailcommon-plugins amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [9,760 B]          
#     Get:375 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5tnef5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [47.1 kB]                       
#     Get:376 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kdepim-addons amd64 16.04.3-1ubuntu1~ubuntu16.04~ppa62 [398 kB]                        
#     Get:377 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kdepim-doc all 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [3,688 kB]                         
#     Get:378 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kdepim-themeeditors amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [188 kB]                
#     Get:379 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kdeplasma-addons-data all 4:5.8.9-0ubuntu1~ubuntu16.04~ppa1 [752 kB]                   
#     Get:380 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kimageformat-plugins amd64 5.36.0-0ubuntu1~ubuntu16.04~ppa1 [75.5 kB]                  
#     Get:381 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kio-audiocd amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa62 [91.2 kB]                       
#     Get:382 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5ksieve-data all 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [3,556 B]                   
#     Get:383 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5kmanagesieve5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [33.0 kB]               
#     Get:384 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5ksieve5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [21.1 kB]                     
#     Get:385 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5ksieveui5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [387 kB]                    
#     Get:386 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5messagelist5 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [269 kB]                 
#     Get:387 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kmail amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [1,517 kB]                            
#     Get:388 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 knotes amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [414 kB]                             
#     Get:389 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kontact amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [305 kB]                            
#     Get:390 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 konversation-data all 1.7.2-0ubuntu1~ubuntu16.04~ppa2 [3,559 kB]                       
#     Get:391 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 konversation amd64 1.7.2-0ubuntu1~ubuntu16.04~ppa2 [828 kB]                            
#     Get:392 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 korganizer amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [1,123 kB]                       
#     Get:393 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 krdc amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [470 kB]                               
#     Get:394 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5krossui5 amd64 5.36.0-0ubuntu1~ubuntu16.04~ppa1 [41.7 kB]                        
#     Get:395 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kross amd64 5.36.0-0ubuntu1~ubuntu16.04~ppa1 [286 kB]                                  
#     Get:396 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 ksystemlog amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [496 kB]                         
#     Get:397 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 ktnef amd64 4:16.04.3-0ubuntu2~ubuntu16.04~ppa63 [130 kB]                              
#     Get:398 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libokularcore7 amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa62 [276 kB]                     
#     Get:399 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 okular amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa62 [1,273 kB]                           
#     Get:400 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 sddm-theme-breeze amd64 4:5.8.9-0ubuntu1~ubuntu16.04~ppa1 [829 kB]                     
#     Get:401 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 python3-dbus.mainloop.pyqt5 amd64 5.5.1+dfsg-3ubuntu5~xenialoverlay11~1 [12.6 kB]      
#     Get:402 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kubuntu-notification-helper amd64 15.10ubuntu2.1~ubuntu16.04~ppa1 [118 kB]             
#     Get:403 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kwin-addons amd64 4:5.8.9-0ubuntu1~ubuntu16.04~ppa1 [24.9 kB]                          
#     Get:404 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5modemmanagerqt6 amd64 5.36.0-0ubuntu1~ubuntu16.04~ppa1 [142 kB]                  
#     Get:405 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5sane-data all 16.04.3-0ubuntu1~ubuntu16.04~ppa62 [7,906 B]                       
#     Get:406 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5unitconversion-data all 5.36.0-0ubuntu1~ubuntu16.04~ppa1 [659 kB]                
#     Get:407 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkf5unitconversion5 amd64 5.36.0-0ubuntu1~ubuntu16.04~ppa1 [96.7 kB]                 
#     Get:408 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkonq5-templates all 4:16.04.3-0ubuntu1~ubuntu16.04~ppa63 [103 kB]                   
#     Get:409 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libkonq-common amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa63 [108 kB]                     
#     Get:410 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libpam-kwallet4 amd64 4:5.8.9-0ubuntu1~ubuntu16.04~ppa1 [11.6 kB]                      
#     Get:411 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libqt5qml-graphicaleffects all 5.6.1-3ubuntu1~xenialoverlay1~2 [3,318 B]               
#     Get:412 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 okular-extra-backends amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa62 [117 kB]              
#     Get:413 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 packagekit amd64 1.1.1-1ubuntu1~ubuntu16.04~ppa1 [545 kB]                              
#     Get:414 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 packagekit-tools amd64 1.1.1-1ubuntu1~ubuntu16.04~ppa1 [46.8 kB]                       
#     Get:415 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 plasma-dataengines-addons amd64 4:5.8.9-0ubuntu1~ubuntu16.04~ppa1 [86.4 kB]            
#     Get:416 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 plasma-discover-common all 5.8.9-0ubuntu1~ubuntu16.04~ppa3 [7,679 kB]                  
#     Get:417 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 qml-module-org-kde-kirigami amd64 1.1.0-1~ubuntu16.04~ppa2 [218 kB]                    
#     Get:418 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 plasma-discover amd64 5.8.9-0ubuntu1~ubuntu16.04~ppa3 [970 kB]                         
#     Get:419 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 plasma-nm amd64 4:5.8.9-0ubuntu1~ubuntu16.04~ppa1 [1,040 kB]                           
#     Get:420 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 plasma-runners-addons amd64 4:5.8.9-0ubuntu1~ubuntu16.04~ppa1 [106 kB]                 
#     Get:421 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 plasma-wallpapers-addons amd64 4:5.8.9-0ubuntu1~ubuntu16.04~ppa1 [24.4 kB]             
#     Get:422 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 plasma-widgets-addons amd64 4:5.8.9-0ubuntu1~ubuntu16.04~ppa1 [296 kB]                 
#     Get:423 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 print-manager amd64 4:16.04.3-0ubuntu1~ubuntu16.04~ppa61 [269 kB]                      
#     Get:424 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 qml-module-qtquick-xmllistmodel amd64 5.6.1-4ubuntu1~xenialoverlay1~4 [39.3 kB]        
#     Get:425 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 qtdeclarative5-xmllistmodel-plugin amd64 5.6.1-4ubuntu1~xenialoverlay1~4 [11.6 kB]     
#     Get:426 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 kdemultimedia-kio-plugins all 4:16.04.3-0ubuntu2~ubuntu16.04~ppa62 [6,014 B]           
#     Get:427 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 libksane-data all 4:16.04.3-0ubuntu1~ubuntu16.04~ppa62 [6,678 B]                       
#     Get:428 http://ppa.launchpad.net/kubuntu-ppa/backports/ubuntu xenial/main amd64 oxygen5-icon-theme all 5:5.36.0-0ubuntu1~ubuntu16.04~ppa1 [9,280 B]                    
#     Fetched 277 MB in 4min 59s (925 kB/s)
#     ...
#

#   $ time home-manager build
#   ...
#   real	10m20.832s
#   user	9m58.296s
#   sys	2m32.928s

########################################


########################################
