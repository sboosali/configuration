##################################################
{ pkgs

, sboo
}:

##################################################
let
#------------------------------------------------#

config = ''
allow-emacs-pinentry
'';

#------------------------------------------------#
in
##################################################
{
  #----------------------------#

  enableSshSupport = true;

  # ^ Whether to use the GnuPG key agent for SSH keys.

  grabKeyboardAndMouse = true;

  # ^ Tell the pinentry to grab the keyboard and mouse. This option should in general be used to avoid X-sniffing attacks. When disabled, this option passes no-grab setting to gpg-agent.

  defaultCacheTtl = 1800;

  # ^ Unit: seconds.
  # Set the time for which a cache entry is valid.

  verbose = true;

  #----------------------------#

  extraConfig = config;

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

  #----------------------------#
}
##################################################
/* Notes 

$ nix-shell '<nixpkgs>' -p isync -p gnupg --run 'isync --version; gpg-agent --version'

  isync 1.3.0

  gpg-agent (GnuPG) 2.2.13
  libgcrypt 1.8.4
  Copyright (C) 2019 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.

*/
#------------------------------------------------#
# EOF -------------------------------------------#
#------------------------------------------------#