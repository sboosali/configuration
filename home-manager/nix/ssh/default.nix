##################################################
{ pkgs

, sboo
, xdg
}:

##################################################
let

inherit (pkgs.stdenv)
        lib;

##################################################

env = {

  HOME = builtins.getEnv "HOME";

};

##################################################

sshFile = path:

  ''${env.HOME}/.ssh/${path}'';

# sshFile = path:
#TODO   "${xdg.configHome}/ssh/${path}";

in
##################################################
let

matchBlocks = rec
{

  ############################

  "github.com" = {
    user     = "git";
    hostname = "github.com";

    identityFile = sshFile "%l_%r@%h_id_rsa";  #TODO
   #extraOptions = {
   #     "_" = "_";
   # };
  };

  ############################

  #TODO# router = { hostname = "192.168.1.2"; user = "root"; };

  #TODO# haskell_org = { host = "*haskell.org"; user = "sboo"; };

  ############################

  id_local = {
    identityFile   = sshFile "id_local";
    identitiesOnly = true;
   #host           = lib.concatStringsSep " " [ ];
  };

  ############################
};

in
##################################################
{

 forwardAgent        = true;
 serverAliveInterval = 60;

 hashKnownHosts      = true;
 userKnownHostsFile  = sshFile "known_hosts";
 
 inherit matchBlocks;

}
##################################################