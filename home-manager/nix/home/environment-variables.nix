##################################################
{ pkgs
, sboo
, xdg
}:
##################################################
let

NIX_PROFILE = "~/.nix-profile";

env = {

 PKG_CONFIG_PATH = builtins.getEnv "PKG_CONFIG_PATH";
 TERMINFO_DIRS   = builtins.getEnv "TERMINFO_DIRS";

};

in
##################################################
{

 CABAL_CONFIG       = "${xdg.configHome}/cabal/config";

 #FONTCONFIG_PATH    = "${xdg.configHome}/fontconfig:/etc/fonts";
 #FONTCONFIG_FILE    = "${xdg.configHome}/fontconfig/fonts.conf";

 ALTERNATE_EDITOR   = "${pkgs.nano}/bin/nano";
# EMACS_SERVER_FILE  = "/tmp/emacsclient.server";
# COLUMNS            = "100";
# EDITOR             = "${pkgs.emacs26}/bin/emacsclient -s /tmp/emacs501/server -a nano";
 EMAIL              = "${sboo.email}";

 GRAPHVIZ_DOT       = "${pkgs.graphviz}/bin/dot";
 GS_OPTIONS         = "-sPAPERSIZE=a4";
 #TODOLC_CTYPE           = "en_US.UTF-8";
 LESS               = "-FRSXM";
#PS1                = "\\D{%H:%M} \\h:\\W $ ";

 #################################################

 GHCVER             = "84";
 GHCPKGVER          = "843";
 EMACSVER           = "26";

 #################################################

 SBOO_CONFIGURATION_DIR = ''"$HOME"/configuration'';
 SBOO_EMACS_DIR         = ''"$HOME"/.emacs.d'';
 SBOO_HASKELL_DIR       = ''"$HOME"/haskell'';
 SBOO_ELISP_DIR         = ''"$HOME"/elisp'';
#SBOO_EMACS             = ''"$HOME"/.emacs.d/result/bin/emacs'';

 #################################################

 PKG_CONFIG_PATH = ''${NIX_PROFILE}/lib/pkgconfig'';

#PKG_CONFIG_PATH = ''${NIX_PROFILE}/lib/pkgconfig:${env.PKG_CONFIG_PATH}''; #TODO getEnv = null vs ""
#TERMINFO_DIRS   = ''"${pkgs.termite}/share/terminfo":/lib/terminfo:${env.TERMINFO_DIRS}''

 #################################################

 LD_PRELOAD = ""; # HACK

}

#TODO
# The problem can occur on Gentoo Linux too. Summarizing the workaround:
# (once) env -u LANG -u LC_MESSAGES -u LC_TIME -u LC_NUMERIC nix-env -iA nixpkgs.glibcLocales
# (in shell init) export LOCALE_ARCHIVE=$HOME/.nix-profile/lib/locale/locale-archive
# https://github.com/NixOS/nix/issues/599

##################################################

# ^ « $ man emacsclient »:
#
#     +line[:column]
#            Go to the specified line and column.  A missing column is treated
#            as column 1.  This option applies only to the  next  file  speci‐
#            fied.
#
#     -a, --alternate-editor=COMMAND
#
#            if  the Emacs server is not running, run the specified shell com‐
#            mand instead.  This can also be specified via the  ALTERNATE_EDI‐
#            TOR  environment  variable.   If the value of ALTERNATE_EDITOR is
#            the empty string, run "emacs --daemon" to start Emacs  in  daemon
#            mode, and try to connect to it.
#
#     -s, --socket-name=FILENAME
#
#            use socket named FILENAME for communication.
#
#
#

##################################################