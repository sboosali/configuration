# cd ~/.config/nixpkgs/ && ln -sf ~/configuration/home-manager/nix/home.nix home.nix

########################################
# ①  Input #############################
########################################

{ pkgs
, ... 
}:

########################################
# ②  Utilities #########################
########################################
let
########################################

sboo = {

  sanfrancisco = {
    longitude = "38";
    latitude  = "122";
  };

  boston = {
    longitude = "42";
    latitude  = "71";
  };

};

########################################

# = ;

########################################
in
########################################
{
########################################
# ③  Packages ##########################
########################################

home.packages = [

    pkgs.htop
    pkgs.fortune

];

########################################
# ④  Programs ##########################
########################################

programs.emacs = {
    enable = true;

    extraPackages = epkgs: with epkgs; [

      use-package
      helm

      haskell-mode
      nix-mode

      projectile
      yasnippet
      magit

    ];
};


####################################

programs.firefox = {
    enable = true;

    enableIcedTea = true;
};

####################################

 programs.git = {
    enable = true;

    userName = "Sam Boosalis";
    userEmail = "samboosalis@gmail.com";
};

####################################

programs.home-manager = {
    enable = true;

    path = https://github.com/rycee/home-manager/archive/release-18.03.tar.gz;
};

# ^ 
# 
# default `programs.home-manager.path` = ''"$HOME"/.config/nixpkgs/home-manager'' (???)
#
# 

########################################
# ⑤  Services ##########################
########################################

services.redshift = {
    enable = true;

    provider  = "manual";
    inherit (sboo.boston) longitude latitude;

#    provider  = "manual";
#    longitude = "42";
#    latitude  = "71";

    temperature.night  = 1000;
    temperature.day    = 20000;

    # ^ min 1000 (red), max 25000 (blue)

    brightness.night  = "0.9";
    brightness.day    = "1.0";

    # ^ min 0.1 (dim, 10%), max 1.0 (bright, 100%)
};

########################################

#TODO# services.gpg-agent = {
#    enable = true;
#
#    defaultCacheTtl = 1800;
#    enableSshSupport = true;
#};

########################################

#TODO# services.ssh-agent = {
#    enable = true;
#
# };

########################################
# ⑥ _ ##################################
########################################

########################################
}
