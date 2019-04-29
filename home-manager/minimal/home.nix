{ pkgs, ... }:

##################################################
let
#------------------------------------------------#

home-manager = {

  submodule = builtins.toString ~/configuration/submodules/home-manager;
  v19_03    = builtins.toString https://github.com/rycee/home-manager/archive/release-19.03.tar.gz;
  v18_09    = builtins.toString https://github.com/rycee/home-manager/archive/release-18.09.tar.gz;

};

#------------------------------------------------#
in
##################################################

{

  programs.firefox = {
    enable = true;
    enableIcedTea = true;
  };

  programs.home-manager = {
    enable = true;
    path = home-manager.v19_03;
  };

}

##################################################