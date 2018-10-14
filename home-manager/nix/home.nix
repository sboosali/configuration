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
      yasnippets
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

    path = ~/.config/nixpkgs/home.nix;
};

#TODO#    path = "$HOME/.config/nixpkgs/home.nix";

########################################
# ⑤  Services ##########################
########################################

services.redshift = {
    enable = true;

    provider = "manual";

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
