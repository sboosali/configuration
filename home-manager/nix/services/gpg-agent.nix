##################################################
{ pkgs

, sboo
}:

##################################################
{

  enableSshSupport = true;

  # ^ Whether to use the GnuPG key agent for SSH keys.

  grabKeyboardAndMouse = true;

  # ^ Tell the pinentry to grab the keyboard and mouse. This option should in general be used to avoid X-sniffing attacks. When disabled, this option passes no-grab setting to gpg-agent.

  defaultCacheTtl = 1800;

  # ^ 

  verbose = true;

  ################################################

  # extraConfig = ''
  # '';

  # ^ Extra configuration lines to append to the gpg-agent configuration file.

  # Type: strings concatenated with "\n"
  #
  # Default: ""
  #
  # Example:
  #
  #   ''
  #   allow-emacs-pinentry
  #   allow-loopback-pinentry
  #   ''

}
##################################################