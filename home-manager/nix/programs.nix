##################################################
{ pkgs

, xdg
, env
, sboo
, utilities
}:

##################################################

with utilities;

##################################################
{

  ################################################

  home-manager.enable = true;

  #home-manager.path   = toString ../../submodules/home-manager;

  home-manager.path = (import ./versions/home-manager.nix).remote;
  # ^

  #TODO:
  # - https://github.com/rycee/home-manager/archive/release-18.09.tar.gz;
  # - ../../submodules/home-manager/

  #TODO:
  #
  # offline-rebuilding via `nix-channel:
  #
  # ```sh
  # $ nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
  #
  #
  # $ nix-channel --update
  #
  #
  # $ ls -la .nix-defexpr/channels/home-manager
  # home-manager.path = "$HOME/.nix-defexpr/channels/home-manager";
  # ```
  #

  ################################################

  emacs =

    (import ./emacs
            { inherit pkgs utilities;
            })

     // { enable = true;
        };

  ################################################

  git =

    (import ./git
            { inherit pkgs sboo;
            })

     // { enable = true;
        };

  ################################################

  ssh =

    (import ./ssh
            { inherit pkgs sboo xdg;
            })

     // { enable = true;
        };

  ################################################

  bash =

    (import ./bash
            { inherit pkgs sboo env xdg;
            })

     // { enable = true;
        };

  ##############################################

  firefox = {
      enable = true;

      #enable = true;
  };
   
  ################################################

  # chromium.enable = true;

  # chromium.extensions = [

  #   "gcbommkclmclpchllfjekcdonpmejbdp" 
  #   # ^ https everywhere

  #   "cjpalhdlnbpafiamejdnhcphjbkeiagm"
  #   # ^ ublock origin

  #   #""
  #   # ^
  # ];

  ##############################################

  termite.enable = true;

  # ^ TERMite is a terminal-emulator, and is:
  # 
  # * is minimal 
  # * is VTE-based 
  # * has modal UI (i.e. like Vim)
  # * 
  # 
  # See « https://wiki.archlinux.org/index.php/termite ».

  # large-font & black-on-white:

  termite.font = "Monospace 24";

  # the Font Description,
  # i.e. Font Family (which should be a monospace font) and Font Size.

  termite.foregroundColor = sboo.colors.black;
  termite.backgroundColor = sboo.colors.white;

  # the BackgroundColor
  # should look soft under `xrandr-invert-colors`.
  # (like purple-gray?)

  #"rgba(192, 64, 192, 0.95)";

  termite.clickableUrl = true; 

  # Whether Auto-detected URLs can be clicked on,
  # to open them in your browser (if a browser is configured or detected.)

  termite.dynamicTitle = true; 

  # Whether the shell can update the terminal's title.

  termite.fullscreen = true;

  # Enables entering fullscreen mode by pressing F11.

  termite.scrollOnKeystroke = true;

  # Scroll to the bottom automatically when a key is pressed.

  termite.scrollbar = "left";

  # Position and presence of the scrollbar.
  #
  # Type: null or one of "off", "left", "right"

  termite.urgentOnBell = true;

  # Sets the window as urgent on the terminal bell.

  termite.allowBold = true;

  # Whether the terminal-emulator outputs bold characters,
  # when the stdout outputs the bold escape-sequence.

  termite.browser = 
  ''${pkgs.xdg_utils}/xdg-open'';

  # Set the default browser for opening links. 
  # 
  # If it's not set, $BROWSER is read.
  # If that too isn't set, url hints will be disabled.
  #
  # e.g.:
  #       programs.termite.browser = ''${pkgs.xdg_utils}/xdg-open'';
  #

  termite.audibleBell = false;

  ################################################

  htop.enable = true;

  ################################################

  feh = {
   enable = true;
  };
   
  ################################################

  texlive = {
   enable = true;

   extraPackages = tpkgs: 
    { inherit (tpkgs)
      resumecls
      resumemac
      collection-fontsrecommended 
      algorithms
      ;
   };

  };

  ################################################

  command-not-found.enable = true;

  ################################################

  man.enable = false;

  # ^
  # Using your system man package should be able to view man pages installed through Nixpkgs since ~/.nix-profile/etc/profile.d/nix.sh contains
  #
  #     if [ -n "${MANPATH}" ]; then
  #         export MANPATH="$NIX_LINK/share/man:$MANPATH"
  #     fi
  #
  # About PAGER variable I guess the Ubuntu man package will use a default value when it is unset? The Nixpkgs man package doesn't seem to have such a default and instead relies on the TODO.

  ################################################

  lesspipe.enable = true;

  # ^ « lesspipe » is a preprocessor for « pipe ».

  ################################################



  ################################################
}
##################################################