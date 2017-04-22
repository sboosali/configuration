{ config, pkgs, lib, ... }:

{
 imports =
    [
    ];

  nixpkgs.config = {
    allowUnfree = true;    
  };

  nix = {

   # reflex-platform
   trustedBinaryCaches = [ "https://nixcache.reflex-frp.org" ];
   binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];

/*
    gc = {
      automatic = true;
      dates = "monthly";
    };
*/

    # Use sandboxed builds.
    # useSandbox = true;

    extraOptions = ''
      auto-optimise-store = true
    '';
  };

  boot.loader.grub.device = "/dev/sda";
  boot.loader.timeout = 0;

  boot.initrd.availableKernelModules = [ "ohci_pci" "ahci" "sd_mod" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/media/sf_host" =
    { device = "host";
      fsType = "vboxsf";
      options = [ "rw" ];
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 2;

  virtualisation.virtualbox.guest.enable = true;

  environment.systemPackages = with pkgs; 
   [ curl
     emacs25
     xlibs.xmessage 
     haskellPackages.ghc
     haskellPackages.xmonad haskellPackages.xmonad-contrib haskellPackages.xmonad-extras
     nix-repl
   ];

/*
 hardware = {
   pulseaudio.enable = true;
   pulseaudio.systemWide = true;
 };
*/

  time.timeZone = "America/Eastern";
  time.hardwareClockInLocalTime = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

 services.mpd = {
  enable = true;

};

users.mutableUsers = true;

users.extraUsers.sboo = {
  name = "sboo";
  # hashedPassword = "";
  initialPassword = "sboo";
  extraGroups = [
    "wheel" "disk" "audio" "video" "power"
    "systemd-journal" "vboxusers" "vboxsf"
  ];
  uid = 1337;
  shell = "/run/current-system/sw/bin/bash";
  isNormalUser = true;
    # createHome = true;
    # home = "/home/sboo";
    # group = "users";
};

users.extraUsers.demo =
    { isNormalUser = true;
      description = "Demo user account";
      extraGroups = [ "wheel" ];
      password = "demo";
      uid = 1000;
    };

 networking = {
  hostName = "chez-sboo";
 };

 services.xserver = {
    enable = true;

    multitouch.enable = true;
    synaptics.enable = true;
    synaptics.twoFingerScroll = true;
    synaptics.vertEdgeScroll = true;
    synaptics.vertTwoFingerScroll = true;

    displayManager.slim = {
        enable = true;
        defaultUser = "sboo";
      };

    windowManager.default = "xmonad";
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
#    windowManager.xmonad.extraPackages = {haskellPackages: []};

    desktopManager.default = "none";
    desktopManager.xterm.enable = false;

/* kde
    desktopManager.default = "kde4";
  # Enable the KDE Desktop Environment.
  displayManager.kdm.enable = true;
  desktopManager.kde4.enable = true;
  };

*/

   enableCtrlAltBackspace = false;
   #xkbOptions = "eurosign:e,grp:caps_toggle,grp_led:scroll,terminate:ctrl_alt_bksp";

 };

#####################################################################################################

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = with pkgs; [
  #   wget
  # ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;

  # Define a user account. Don't forget to set a password with â€˜passwdâ€™.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };


}
