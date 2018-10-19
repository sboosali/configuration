# Notes

## `home-manager`

## `home-manager-path/`



```nix

  home.path = pkgs.buildEnv {

      name = "home-manager-path";

      paths = cfg.packages;
      inherit (cfg) extraOutputsToInstall;

      postBuild = cfg.extraProfileCommands;

      meta = {
        description = "Environment of packages installed through home-manager";
      };
  
  };
```

## `ssh-agent`

Why `eval "$(ssh-agent -s)"`? Because:

```sh
$ ssh-agent -s

SSH_AUTH_SOCK=/tmp/ssh-YnCfVnisRwpN/agent.26772; 
export SSH_AUTH_SOCK;

SSH_AGENT_PID=26773; 
export SSH_AGENT_PID;

echo Agent pid 26773;
```

```sh
$ echo $SSH_AGENT_PID

$ eval "$(ssh-agent -s)"
Agent pid 26773;

$ echo $SSH_AGENT_PID
26941
```

```sh
$ which ssh-agent 
/usr/bin/ssh-agent

$ which ssh-add
/usr/bin/ssh-add
```

## `mk*`

* `mkIf`:

* `mkBefore`:

  > Note that both `configuration.nix` and `kde.nix` define the option
  > `opt-environment.systemPackages`. 
  > 
  > When multiple modules define an option, 
  > NixOS will try to **merge** the
  > definitions. In the case of `opt-environment.systemPackages`,
  > that’s easy: the lists of packages can simply be concatenated. The value in
  > `configuration.nix` is merged last, so for list-type
  > options, it will appear at the end of the merged list. If you want it to
  > appear first, you can use `mkBefore`.
  > 
  >  e.g. this:
  > 
  >   `opt-boot.kernelModules = mkBefore [ "kvm-intel" ];`
  > 
  > causes the `kvm-intel` kernel module to be loaded
  > before any other kernel modules.
  > 

## `terminfo`

Links:

* <https://invisible-island.net/ncurses/man/ncurses.3x.html#h3-TERMINFO>

* <https://linux.die.net/man/5/terminfo>

Notes:

* `ncurses`:

> The  ncurses  library  routines  give  the  user a terminal-independent
>       method of updating  character  screens  with  reasonable  optimization.
>       This  implementation  is  "new  curses"  (ncurses)

* `$TERMINFO` and `$TERMINFO_DIRS`:

> Setting TERMINFO is the simplest, but not the only way to set  location
> of  the default terminal database.  The complete list of database loca-
> tions in order follows:
> 
>    o   the last terminal database to which ncurses wrote,  if  any,  is
>        searched first
> 
>    o   the location specified by the TERMINFO environment variable
> 
>    o   $HOME/.terminfo
> 
>    o   locations listed in the TERMINFO_DIRS environment variable
> 
>    o   one  or  more  locations whose names are configured and compiled
>        into the ncurses library, i.e.,
> 
>       o   /usr/local/ncurses/share/terminfo:/usr/share/terminfo (corre-
>           sponding to the TERMINFO_DIRS variable)
> 
>       o   /usr/share/terminfo (corresponding to the TERMINFO variable)
> 

## ISSUE: `tput` fails for `termite` (its `terminfo` isn't registered?)

`tput` fails for `termite` with:

```
tput: unknown terminal "xterm-termite"
```

But `tput` works for other terminals, like the default terminal whose `$TERM` is `xterm-256color`. Which makes sense, because it's in `/lib/terminfo/`, the default `$TERMINFO` database distributed:

```
/lib/terminfo/x/xterm-256color
```

I'm on Ubuntu 16.04 under KDE Plasma 5, and my `home.nix` includes

* `bash`:

```nix
programs.bash.enable = true;
programs.bash.bashrcExtra = ''
tput ...
'';
```

* `termite`:

```nix
programs.termite.enable = true;
'';
```

* and has `home-manager` version:

```nix
programs.home-manager = {
  enable = true;
  path = https://github.com/rycee/home-manager/archive/release-18.03.tar.gz;
};
```

I don't know how `home-manager` works, as after exploring `home-manager-generation:

```sh
$ home-manager generations
... -> /nix/store/bm8gyd8lbxyshqdnyv15kbxvyd42v921-home-manager-generation

$ cd /nix/store/bm8gyd8lbxyshqdnyv15kbxvyd42v921-home-manager-generation

$ find -L . -type f | grep -I terminfo
./home-path/share/terminfo/x/xterm-termite
```

I'm stuck on how to properly "register" this. 

Assuming `terminfo.enable` doesn't register `.../share/terminfo/x/xterm-termite` on non-NixOS? Or if it does, and the rest of my config intereferes somehow (though `tput` still fails even with no extra `.bashrc`).

Finally, I could manually link the `share/terminfo` from `nix`:

```sh
/home/sboo/.nix-profile/share/terminfo/x/xterm-termite
```

into the outside-the-home path `/lib/terminfo` (but only if I've got to).

My current workaround is adding the `nix`-generated `terminfo` database to (the otherwise empty) `$TERMINFO_DIRS`:

```nix

```

from my `.bashrc`. like so:

```nix
programs.bash.bashrcExtra =
  ''
  export TERMINFO_DIRS="$HOME/.nix-profile/share/terminfo":/lib/terminfo
  '';
```

Since I don't know how any of these systems actually interact (or even what level they're on), I don't know if this is the right way to do this, or not. 

So, my question is if there's more general solution (like for all standard subdirectories of  `~/.nix-profile/share/`) that `home-manager` provides. And if there isn't, can we add this to the wiki (?), or to the <https://rycee.gitlab.io/home-manager/options.html> (under each support terminal program, like `programs.termite`)?

Thanks.

Links:

* <https://invisible-island.net/ncurses/man/ncurses.3x.html#h3-TERMINFO>
* <https://linux.die.net/man/5/terminfo>

## `ssh`

the `openssh` packages provides the `ssh` program (and other `ssh-*` programs):

```nix
"${pkgs.openssh}/bin/ssh"
```

```sh
$ cd /nix/store/*-openssh-*/

$ find -L bin/ -type f -executable
./bin/ssh-keygen
./bin/sshd
./bin/ssh-copy-id
./bin/ssh
./bin/scp
./bin/ssh-keyscan
./bin/ssh-agent
./bin/sftp
./bin/ssh-add
```

## `xbindkeys`

XBindKeys Daemon:

```sh
$ xbindkeys --file       ~/.xbindkeysrc     &disown
$ xbindkeys --file-guile ~/.xbindkeysrc.scm &disown 
```

```man
-f,  --file         Use an alternative rc file
-fg, --file-guile   Use an alternative guile configuration file
```

## `emacs`

```sh
$ emacs --daemon
```

`--daemon` launches an emacs daemon: 

- starting the server,
- running any elisp init files, and then 
- detaching into the background.

## `KDE Plamsa`

### `$ systemsettings5`

TODO mv settings-via-ui into `home.nix`.

#### `Settings > Fonts > Fonts`

Fonts (Family & Size):

* General: 
* FixedWidth: 
* Small: 
* Toolbar: 
* Menu: 
* WindowTitle: 

(the defaults are all 9 or 10, which are illegible on high-resolution monitors).

## LightDM

### LightDM: Before Reconfiguration (after Installation)

```sh
$ find /etc/rc2.d

/etc/rc2.d
/etc/rc2.d/S01uuidd
/etc/rc2.d/S02anacron
/etc/rc2.d/S05plymouth
/etc/rc2.d/S05grub-common
/etc/rc2.d/S04cups-browsed
/etc/rc2.d/S05rc.local
/etc/rc2.d/README
/etc/rc2.d/S03lightdm
/etc/rc2.d/S01apport
/etc/rc2.d/S02sddm
/etc/rc2.d/S02kerneloops
/etc/rc2.d/S01lvm2-lvmetad
/etc/rc2.d/S04cups
/etc/rc2.d/S02cron
/etc/rc2.d/S03bluetooth
/etc/rc2.d/S02acpid
/etc/rc2.d/S03avahi-daemon
/etc/rc2.d/S02irqbalance
/etc/rc2.d/S02whoopsie
/etc/rc2.d/S01rsyslog
/etc/rc2.d/S02smartmontools
/etc/rc2.d/S01unattended-upgrades
/etc/rc2.d/S04saned
/etc/rc2.d/S05ondemand
/etc/rc2.d/S02rsync
/etc/rc2.d/S02dbus
/etc/rc2.d/S02thermald
/etc/rc2.d/S02speech-dispatcher
/etc/rc2.d/S01lvm2-lvmpolld
/etc/rc2.d/S01tlp
```

```sh
$ find /etc/lightdm/

/etc/lightdm/
/etc/lightdm/users.conf
/etc/lightdm/lightdm.conf
/etc/lightdm/lightdm.conf.d
```

```sh
$ cat /etc/lightdm/lightdm.conf

[Seat:*]
autologin-guest=false
autologin-user=sboo
autologin-user-timeout=0
```

```sh
$ systemctl status lightdm.service

● lightdm.service - Light Display Manager
   Loaded: loaded (/lib/systemd/system/lightdm.service; enabled; vendor preset: enabled)
  Drop-In: /lib/systemd/system/display-manager.service.d
           └─xdiagnose.conf
   Active: active (running) since Sun 2018-10-14 22:07:52 PDT; 3 days ago
     Docs: man:lightdm(1)
  Process: 1330 ExecStartPre=/bin/sh -c [ "$(basename $(cat /etc/X11/default-display-manager 2>/dev/null))" = "lightdm" ] (code=exited, status=0/SUCCESS)
 Main PID: 1335 (lightdm)
   CGroup: /system.slice/lightdm.service
           ├─1335 /usr/sbin/lightdm
           └─1350 /usr/lib/xorg/Xorg -core :0 -seat seat0 -auth /var/run/lightdm/root/:0 -nolisten tcp vt7 -novtswitch

Oct 14 22:07:51 SpirOS systemd[1]: Starting Light Display Manager...
Oct 14 22:07:52 SpirOS systemd[1]: Started Light Display Manager.
Oct 14 22:07:52 SpirOS lightdm[1454]: pam_unix(lightdm-autologin:session): session opened for user sboo by (uid=0)
```

```sh
$ dm-tool --help

Usage:
  dm-tool [OPTION...] COMMAND [ARGS...] - Display Manager tool

Options:
  -h, --help        Show help options
  -v, --version     Show release version
  --session-bus     Use session D-Bus

Commands:
  switch-to-greeter                                    Switch to the greeter
  switch-to-user USERNAME [SESSION]                    Switch to a user session
  switch-to-guest [SESSION]                            Switch to a guest session
  lock                                                 Lock the current seat
  list-seats                                           List the active seats
  add-nested-seat [--fullscreen|--screen DIMENSIONS]   Start a nested display
  add-local-x-seat DISPLAY_NUMBER                      Add a local X seat
  add-seat TYPE [NAME=VALUE...]                        Add a dynamic seat
```

```sh
$ dm-tool list-seats 

Seat0
  CanSwitch=true
  HasGuestAccount=true
  Session0
    UserName='sboo'
```

```sh
$ lsb_release -rd

Description: Ubuntu 16.04.5 LTS
Release:     16.04
```


### LightDM: After Configuration

Add `user-session=plasma` under `SeatDefaults` to `/etc/lightdm/lightdm.conf`:

```sh
$ cat /etc/lightdm/lightdm.conf

[Seat:*]
autologin-guest=false
autologin-user=sboo
autologin-user-timeout=0

[SeatDefaults]
user-session=plasma
```

where `/usr/share/xsessions/plasma.desktop` must exist.

## 

