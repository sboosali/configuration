##################################################
{ pkgs
, sboo

, self
}:

##################################################

#with pkgs; 

##################################################
{
  ################################################

  programs.emacs =

    (import ./emacs
            { inherit pkgs utilities;
            })

     // { enable = true;
        };

  ################################################

  programs.git =

    (import ./git
            { inherit pkgs sboo;
            })

     // { enable = true;
        };

  ################################################

  programs.ssh =

    (import ./home/ssh.nix
            { inherit pkgs sboo;
              inherit (self) xdg;
            })

     // { enable = true;
        };

  ################################################

  programs.bash =

    (import ./bash
            { inherit pkgs sboo env;
              inherit (self) xdg;
            })

     // { enable = true;
        };

  ##############################################

  programs.firefox = {
      enable = true;

      #enable = true;
  };
   
  ################################################

  # programs.chromium.enable = true;

  # programs.chromium.extensions = [

  #   "gcbommkclmclpchllfjekcdonpmejbdp" 
  #   # ^ https everywhere

  #   "cjpalhdlnbpafiamejdnhcphjbkeiagm"
  #   # ^ ublock origin

  #   #""
  #   # ^
  # ];

  ##############################################

  programs.termite.enable = true;

  # ^ TERMite is a terminal-emulator, and is:
  # 
  # * is minimal 
  # * is VTE-based 
  # * has modal UI (i.e. like Vim)
  # * 
  # 
  # See « https://wiki.archlinux.org/index.php/termite ».

  # large-font & black-on-white:

  programs.termite.font = "Monospace 24";

  # the Font Description,
  # i.e. Font Family (which should be a monospace font) and Font Size.

  programs.termite.foregroundColor = sboo.colors.black;
  programs.termite.backgroundColor = sboo.colors.white;

  # the BackgroundColor
  # should look soft under `xrandr-invert-colors`.
  # (like purple-gray?)

  #"rgba(192, 64, 192, 0.95)";

  programs.termite.clickableUrl = true; 

  # Whether Auto-detected URLs can be clicked on,
  # to open them in your browser (if a browser is configured or detected.)

  programs.termite.dynamicTitle = true; 

  # Whether the shell can update the terminal's title.

  programs.termite.fullscreen = true;

  # Enables entering fullscreen mode by pressing F11.

  programs.termite.scrollOnKeystroke = true;

  # Scroll to the bottom automatically when a key is pressed.

  programs.termite.scrollbar = "left";

  # Position and presence of the scrollbar.
  #
  # Type: null or one of "off", "left", "right"

  programs.termite.urgentOnBell = true;

  # Sets the window as urgent on the terminal bell.

  programs.termite.allowBold = true;

  # Whether the terminal-emulator outputs bold characters,
  # when the stdout outputs the bold escape-sequence.

  programs.termite.browser = 
  ''${pkgs.xdg_utils}/xdg-open'';

  # Set the default browser for opening links. 
  # 
  # If it's not set, $BROWSER is read.
  # If that too isn't set, url hints will be disabled.
  #
  # e.g.:
  #       programs.termite.browser = ''${pkgs.xdg_utils}/xdg-open'';
  #

  programs.termite.audibleBell = false;

  ################################################

  programs.htop.enable = true;

  ################################################

  programs.feh = {
   enable = true;
  };
   
  ################################################

  programs.texlive = {
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

  programs.command-not-found.enable = true;

  ################################################

  programs.man.enable = false;

  # ^
  # Using your system man package should be able to view man pages installed through Nixpkgs since ~/.nix-profile/etc/profile.d/nix.sh contains
  #
  #     if [ -n "${MANPATH}" ]; then
  #         export MANPATH="$NIX_LINK/share/man:$MANPATH"
  #     fi
  #
  # About PAGER variable I guess the Ubuntu man package will use a default value when it is unset? The Nixpkgs man package doesn't seem to have such a default and instead relies on the TODO.

  ################################################

  programs.lesspipe.enable = true

  # ^ « lesspipe » is a preprocessor for « pipe ».

  ################################################



  ################################################
}
##################################################