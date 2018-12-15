
    ssh = {
      enable = true;

      # controlMaster  = "auto";
      # controlPath    = "/tmp/ssh-%u-%r@%h:%p";
      # controlPersist = "1800";

      forwardAgent = true;
      serverAliveInterval = 60;

      hashKnownHosts = true;
      userKnownHostsFile = "${xdg.configHome}/ssh/known_hosts";

      matchBlocks =
        let amLocal = false;
            hostOnVulcan = ipaddr: {
              hostname     = ipaddr;
              proxyCommand = "${pkgs.openssh}/bin/ssh -q vulcan "
                           + "/run/current-system/sw/bin/socat - TCP:%h:%p";
            };
        in rec {
        hermes.hostname  = "192.168.1.65";
        hermesw.hostname = "192.168.1.67";
        hermesr = {
          hostname = "127.0.0.1";
          port = 2222;
        };
        fin.hostname     = "192.168.1.80";
        tank = fin;

        vulcan =
          if amLocal
          then { hostname = "192.168.1.69"; }
          else {
            hostname = "76.234.69.149";
            port = 2201;
            extraOptions = {
              "LocalForward" = "5999 127.0.0.1:5900";
            };
          };

        router = { hostname = "192.168.1.2"; user = "root"; };

        id_local = {
          host = lib.concatStringsSep " " [
            "fiat" "hermes" "home" "mac1*" "macos*" "nixos*" "mohajer" "fin"
            "dfinity" "peta" "smokeping" "tails" "tank" "titan" "ubuntu*"
            "vulcan"
          ];
          identityFile = "${xdg.configHome}/ssh/id_local";
          identitiesOnly = true;
        };

        nixos   = hostOnVulcan "192.168.118.128";
        dfinity = hostOnVulcan "192.168.118.129";
        macos   = hostOnVulcan "192.168.118.130";

        smokeping = { hostname = "192.168.1.78"; user = "smokeping"; };

        elpa = { hostname = "elpa.gnu.org"; user = "root"; };

        savannah.hostname  = "git.sv.gnu.org";
        fencepost.hostname = "fencepost.gnu.org";
        launchpad.hostname = "bazaar.launchpad.net";
        mail.hostname      = "mail.haskell.org";

        haskell_org = { host = "*haskell.org"; user = "root"; };
      };
    };
  };
