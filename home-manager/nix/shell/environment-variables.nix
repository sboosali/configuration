##################################################
{ pkgs

, sboo
, xdg
, shellUtilities
}:
##################################################
let
#-----------------------------------------------#

paths = import ./paths.nix { };

#-----------------------------------------------#

browser = "google-chrome";

# browser = "firefox";
# browser = "google-chrome";

#-----------------------------------------------#

locale = {

  en_US.UTF-8 = "en_US.UTF-8";

};

#-----------------------------------------------#

language = {

  en_US = "en_US";

};

#-----------------------------------------------#
in
##################################################
let
#-----------------------------------------------#

env = {

 PKG_CONFIG_PATH = builtins.getEnv "PKG_CONFIG_PATH";
 TERMINFO_DIRS   = builtins.getEnv "TERMINFO_DIRS";

};

#-----------------------------------------------#

less = ''${pkgs.less}/bin/less'';

#-----------------------------------------------#

NIX_PROFILE = builtins.toString ~/.nix-profile;

#-----------------------------------------------#
in
##################################################
{

 #-----------------------------------------------#

 PATH = shellUtilities.makePath paths;

 #-----------------------------------------------#

 LD_PRELOAD = ""; #HACK# 

 #-----------------------------------------------#

 BROWSER = browser;

 #FONTCONFIG_PATH    = "${xdg.configHome}/fontconfig:/etc/fonts";
 #FONTCONFIG_FILE    = "${xdg.configHome}/fontconfig/fonts.conf";

 ALTERNATE_EDITOR   = "${pkgs.nano}/bin/nano";
# EMACS_SERVER_FILE  = "/tmp/emacsclient.server";
# COLUMNS            = "100";
# EDITOR             = "${pkgs.emacs26}/bin/emacsclient -s /tmp/emacs501/server -a nano";
 EMAIL              = "${sboo.email}";

 #----------------------------------------------#

 PAGER = less;

 LESS               = "-FRSXM";

 #----------------------------------------------#

 LANGUAGE = language.en_US;
 LANG     = locale.en_US.UTF-8;

# LC_ALL            = locale.en_US.UTF-8;
 LC_CTYPE          = locale.en_US.UTF-8;
 LC_NUMERIC        = locale.en_US.UTF-8;
 LC_TIME           = locale.en_US.UTF-8;
 LC_COLLATE        = locale.en_US.UTF-8;
 LC_MONETARY       = locale.en_US.UTF-8;
 LC_MESSAGES       = locale.en_US.UTF-8;
 LC_PAPER          = locale.en_US.UTF-8;
 LC_NAME           = locale.en_US.UTF-8;
 LC_ADDRESS        = locale.en_US.UTF-8;
 LC_TELEPHONE      = locale.en_US.UTF-8;
 LC_MEASUREMENT    = locale.en_US.UTF-8;
 LC_IDENTIFICATION = locale.en_US.UTF-8;

 #----------------------------------------------#

 GRAPHVIZ_DOT       = "${pkgs.graphviz}/bin/dot";
 GS_OPTIONS         = "-sPAPERSIZE=a4";

 #-----------------------------------------------#

 GHCVER             = "84";
 GHCPKGVER          = "843";
 EMACSVER           = "26";

 #-----------------------------------------------#

 SBOO_CONFIGURATION_DIR = ''"$HOME"/configuration'';
 SBOO_EMACS_DIR         = ''"$HOME"/.emacs.d'';
 SBOO_HASKELL_DIR       = ''"$HOME"/haskell'';
 SBOO_ELISP_DIR         = ''"$HOME"/elisp'';
#SBOO_EMACS             = ''"$HOME"/.emacs.d/result/bin/emacs'';

 #-----------------------------------------------#

 PKG_CONFIG_PATH = ''${NIX_PROFILE}/lib/pkgconfig'';

#PKG_CONFIG_PATH = ''${NIX_PROFILE}/lib/pkgconfig:${env.PKG_CONFIG_PATH}''; #TODO getEnv = null vs ""

 #-----------------------------------------------#

#TERMINFO_DIRS   = ''"${pkgs.termite}/share/terminfo":/lib/terminfo:${env.TERMINFO_DIRS}''

 #----------------------------------------------#

 #TODO# GNUPGHOME = xdgDir "gnupg";

 # ^ « $GNUPGHOME » defaults to « $HOME » (i.e. « ~/.gnupg »).

 #----------------------------------------------#

 #TODO# EMACSLOADPATH = xdgConfigDir "site-lisp";

 # ^ « $EMACSLOADPATH » sets « load-path »
 #   
 #   if « $EMACSLOADPATH » is unset or empty, the « load-path » defaults to,
 #   for example, « '( "/usr/local/share/emacs/26.1/site-lisp" ) ».

 #----------------------------------------------#

 CABAL_CONFIG       = "${xdg.configHome}/cabal/config";

 #-----------------------------------------------#



 #----------------------------------------------#
}
##################################################
# Notes ##########################################
##################################################
/*

« LC_ALL=... » fixes this error:

    $ colordiff 
    perl: warning: Setting locale failed.
    perl: warning: Please check that your locale settings:
    	LANGUAGE = "en_US",
    	LC_ALL = (unset),
    	LANG = "en_US.UTF-8"
        are supported and installed on your system.
    perl: warning: Falling back to the standard locale ("C").

locale environment-variables include:

* « LC_CTYPE       »
* « LC_COLLATE     »
* « LC_TIME        »
* « LC_MESSAGES    »
* « LC_MONETARY    »
* « LC_PAPER       »
* « LC_MEASUREMENT »

e.g.:

  $ echo $LC_ALL

  $ echo $LC_CTYPE

  $ echo $LC_COLLATE

  $ echo $LC_TIME

  $ echo $LC_MESSAGES

  $ echo $LC_MONETARY

  $ echo $LC_PAPER

  $ echo $LC_MEASUREMENT

  $ echo $LANG
  en_US.UTF-8

  $ echo $LANGUAGE 
  en_US



*/

#TODO
# The problem can occur on Gentoo Linux too. Summarizing the workaround:
# (once) env -u LANG -u LC_MESSAGES -u LC_TIME -u LC_NUMERIC nix-env -iA nixpkgs.glibcLocales
# (in shell init) export LOCALE_ARCHIVE=$HOME/.nix-profile/lib/locale/locale-archive
# https://github.com/NixOS/nix/issues/599

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