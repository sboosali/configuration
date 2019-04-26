##################################################
{ lib
, pkgs

, cfgProgram                    # « programs.xbindkeys._ »
, cfgService                    # « services.xbindkeys._ »
}:

##################################################
let
#------------------------------------------------#

xbindkeys = ''${cfgProgram.finalPackage}/bin/xbindkeys'';

#------------------------------------------------#

killall = ''${pkgs.killall}/bin/killall'';

#bash = ''${pkgs.stdenv.shell}'';

#------------------------------------------------#

default_XBINDKEYSRC_FILE   = ''"$XDG_CONFIG_HOME"/xbindkeys/xbindkeysrc'';
default_XBINDKEYSRC_OPTION = ''-f ${default_XBINDKEYSRC_FILE}'';

# ^ “late-binding” for the xdg environment-variable.

# dslXbindkeysRc    = ''-f "$XDG_CONFIG_HOME"/xbindkeys/xbindkeysrc'';
# schemeXbindkeysRc = ''-fg "$XDG_CONFIG_HOME"/xbindkeys/xbindkeysrc.scm'';

#------------------------------------------------#

XBINDKEYSRC_FILE =

  let
  choices =
    {
     "xbindkeys" = cfgService.config;
     "guile"     = cfgService.configGuile;
    };

  chosen = choices.''${cfgService.finalLanguage}'';
  in

  chosen;

# ^ a filepath

#------------------------------------------------#

XBINDKEYSRC_OPTION =

  let
  choices =
    {
     "xbindkeys" = ''-f ${cfgService.config}'';
     "guile"     = ''-fg ${cfgService.configGuile}'';
    };

  chosen = choices.''${cfgService.finalLanguage}'';
  in

  chosen;

# ^ a command-line option with its (filepath) argument.

#------------------------------------------------#
in
##################################################

{

  Unit = {
    Description           = "XBindKeys global-keybinding daemon";
    Documentation         = ''man:xbindkeys(1) https://www.nongnu.org/xbindkeys/xbindkeys.html'';
    After = [ "graphical-session-pre.target" ];
    PartOf = [ "graphical-session.target" ];
    AssertPathExists      = ''${XBINDKEYSRC_FILE}'';
  # StartLimitInterval    = 0;
  };

  Service = {
    ExecStart  = ''${xbindkeys} -n ${XBINDKEYSRC_OPTION} '';
    ExecReload = ''${killall} -HUP xbindkeys'';
    Type       = "simple";
    Restart    = "on-failure";
    RestartSec = 1;

    # NOTE
    #
    # • « Type= » — The command « xbindkeys -n » means “no-daemon”,
    #   which implies the service should be « Type=simple »;
    #   The command « xbindkeys » means “yes-daemon”,
    #   which implies the service should be « Type=forking ».
    #   If « ExecStart= » is changed,
    #   then « Type= » should be updated too.
    #
    # • « ExecReload= » — should be synchronous (if possible);
    #   however, « kill » is asynchronous.
    #
    # • « kill » is a shell-builtin (c.f. « $ type kill »).
    #   The « Exec*= » fields require absolute-filepaths to executables.
    #   Hence, the shell-builtin is wrapped within a shell-call;
    #   c.f. « ExecReload=bash -l -c '...'  »,
    #   with an absolute-filepath to « .../bin/bash ».
    #
    # • « bash -l -c »:
    #     • « -c STRING » — run the given command.
    #     • « -l » — run as a Login-Shell.
    #

  };

  Install = {
    WantedBy = [ "xsession.target" ];
  # WantedBy = [ "xsession.target" ];
  };

}

# Links (for maintainers):
#
# • <https://superuser.com/questions/759759/writing-a-service-that-depends-on-xorg>
#

/* TODO...

Environment=''GUILE_PATH=${pkgs.guile?}'';
# Register Nix-Installed Guile packages with XBindKeys.

*/