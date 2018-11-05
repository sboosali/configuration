# Notes

Notes about: 

* `home-manager` 
* `nixpkgs`
* `xfce`
* `bash`
* `linux`

## Links

overlays/emacs.nix (jwiegley/nix-config)>

<https://github.com/jwiegley/nix-config/blob/master/overlays/emacs/builder.nix emacs/builder.nix (jwiegley/nix-config)>


## `lib/fixed-points.nix`

https://github.com/NixOS/nixpkgs/blob/18.09/lib/fixed-points.nix

### `lib.fix`

Type: 

```haskell
fix :: (a -> a) -> a
```

Definition:

```nix
fix = f: 

  let x = f x
  in  x;
```

`fix f` "resolves" the fixed point of `f`

`f` is an "endormorphism" (i.e. `f :: a -> a`)

often, `f` is a "package extension"; an AttributeSet that "expects its final, non-recursive representation as an argument". e.g.:

```nix
f = self:

  { foo = "foo"; 
    bar = "bar"; 
    foobar = self.foo + self.bar; 
  }
```

the FixedPointProperty for a function `f` is `f x = x`.

`(fix f)` satisfies the FixedPointProperty for **any** "appropriate" function `f`, i.e. `(fix f) x = x`... where "appropriate" means its recursion is coherent under `fix`, i.e. that `(fix f)` terminates.

> Nix repeatedly evaluates this recursion until all references to `self` have been resolved. Once `self` gets resolved, the final result can be returned, and the FixedPointProperty `f x = x` holds:

     nix-repl> fix f
     { bar = "bar"; foo = "foo"; foobar = "foobar"; }

### `lib.extends`

Type: 

```haskell
extends :: (a -> a -> a) 
        -> (a -> a) 
        -> (a -> a) 
```

Definition (`nixpkgs`):

```nix
extends = f: rattrs: self: let super = rattrs self; in super // f self super;
```

Definition (mine):

```nix
extends = k: f:
          self:

  let super = f self;
      x     = k self super;
  in 
  
  super // x

```

Inputs:

* `f :: AttrSet -> AttrSet` is called an **"override"** or a "recursive attribute-set" (or, when the attributes represent packages, a "recursive package-set").
* `k :: AttrSet -> AttrSet -> AttrSet` is called an **"overlay"**.

NOTE the `f` in `(extends _ f)` and `(fix f)` share the same type:

```haskell
k :: a -> a -> a
f :: a -> a
```

as does the (saturated) `(extends _ _)` itself:

```haskell
extends k   :: (a -> a) -> (a -> a)

extends k f :: a -> a
```

NOTE `fix` and `extends` "resolve" recurisve-packages and multiple overlays into non-recurisve packages. i.e. given:

```haskell
f           :: (a -> a)
extends k   :: (a -> a) -> (a -> a)
fix         :: (a -> a) -> a
```

we evaluate to:

```haskell
     extends k f  :: a -> a
fix (extends k f) :: a

fix (extends k2 (extends k1 f)) :: a
```

Read `extends` as an infix operator and with arguments flipped. 
i.e. read `(extends f _)` as `"g extends f"` (this mimics the `Java` syntax).
Why flipped? For cascading multiple `extends`, e.g.:

```nix
g = extends k3
      (extends k2
        (extends k1 
          f))
```

> Modify the contents of an explicitly recursive attribute set in a way that
> honors `self`-references. This is accomplished with a function
>
>     g = self: super: { foo = super.foo + " + "; }
>
> that has access to the unmodified input (`super`) as well as the final
> non-recursive representation of the attribute set (`self`). 
>
> `extends` differs from the native `//` operator insofar as that it's
> applied *before* references to `self` are resolved:
>
>     nix-repl> fix (extends g f)
>     { bar = "bar"; foo = "foo + "; foobar = "foo + bar"; }
> 

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

## `xkeyboard`

<https://unix.stackexchange.com/questions/45447/other-than-alt-shift-to-switch-keyboard-layout-any-other-xorg-key-combination>



## `coreutils`

```sh
$ cd /nix/store/*-coreutils-8.30

$ find -L ./bin -type f | sort

./bin/[
./bin/b2sum
./bin/base32
./bin/base64
./bin/basename
./bin/cat
./bin/chcon
./bin/chgrp
./bin/chmod
./bin/chown
./bin/chroot
./bin/cksum
./bin/comm
./bin/coreutils
./bin/cp
./bin/csplit
./bin/cut
./bin/date
./bin/dd
./bin/df
./bin/dir
./bin/dircolors
./bin/dirname
./bin/du
./bin/echo
./bin/env
./bin/expand
./bin/expr
./bin/factor
./bin/false
./bin/fmt
./bin/fold
./bin/groups
./bin/head
./bin/hostid
./bin/id
./bin/install
./bin/join
./bin/kill
./bin/link
./bin/ln
./bin/logname
./bin/ls
./bin/md5sum
./bin/mkdir
./bin/mkfifo
./bin/mknod
./bin/mktemp
./bin/mv
./bin/nice
./bin/nl
./bin/nohup
./bin/nproc
./bin/numfmt
./bin/od
./bin/paste
./bin/pathchk
./bin/pinky
./bin/pr
./bin/printenv
./bin/printf
./bin/ptx
./bin/pwd
./bin/readlink
./bin/realpath
./bin/rm
./bin/rmdir
./bin/runcon
./bin/seq
./bin/sha1sum
./bin/sha224sum
./bin/sha256sum
./bin/sha384sum
./bin/sha512sum
./bin/shred
./bin/shuf
./bin/sleep
./bin/sort
./bin/split
./bin/stat
./bin/stdbuf
./bin/stty
./bin/sum
./bin/sync
./bin/tac
./bin/tail
./bin/tee
./bin/test
./bin/timeout
./bin/touch
./bin/tr
./bin/true
./bin/truncate
./bin/tsort
./bin/tty
./bin/uname
./bin/unexpand
./bin/uniq
./bin/unlink
./bin/uptime
./bin/users
./bin/vdir
./bin/wc
./bin/who
./bin/whoami
./bin/yes
```

## `findutils`

```sh
$ cd /nix/store/*-findutils-4.6.0

$ find -L ./bin -type f | sort

./bin/find
./bin/locate
./bin/updatedb
./bin/xargs
```

## `xdg-utils`

```sh
$ cd /nix/store/*-xdg-utils-1.1.3

$ find -L ./bin -type f | sort

./bin/xdg-desktop-icon
./bin/xdg-desktop-menu
./bin/xdg-email
./bin/xdg-icon-resource
./bin/xdg-mime
./bin/xdg-open
./bin/xdg-screensaver
./bin/xdg-settings
```


## Locales

Register your locale via `locale-gen` and `/etc/locale.gen`:

```sh
$ echo "en_US.UTF-8 UTF-8" > /etc/locale.gen #TODO# tee

$ sudo locale-gen en_US en_US.UTF-8
$ sudo locale-gen en_US en_US.UTF-8
Generating locales...
  en_US.ISO-8859-1... done
  en_US.UTF-8... done
Generation complete.
```

which builds these locales:

* `en_US.UTF-8`
* `en_US.ISO-8859-1`

(or interactively, via `dpkg-reconfigure locales`: `sudo dpkg-reconfigure locales`).

Links:

<https://unix.stackexchange.com/questions/269159/problem-of-cant-set-locale-make-sure-lc-and-lang-are-correct>

> Debian ships locales in source form. They need to be compiled explicitly. The reason for this is that compiled locales use a lot more disk space, but most people only use a few of them.
> 
> Run dpkg-reconfigure locales as root, select the locales you want in the list (with your settings, you need en_GB and en_US.UTF-8 — I recommend selecting en_US and en_GB.UTF-8 as well) then press <OK>.
> 
> Alternatively, edit /etc/locale.gen, uncomment the lines for the locales you want, and run locale-gen as root.
> 
> (Note: on Ubuntu, this works differently: run locale-gen with the locales you want to generate as arguments, e.g. sudo locale-gen en_GB en_US en_GB.UTF-8 en_US.UTF-8.)
> 
> Alternatively, Debian now has a package locales-all which you can install instead of locales. It has all the locales pre-generated. The downside is that they use up more disk space (112MB vs 16MB).
> 

## `xinitrc`

<https://wiki.archlinux.org/index.php/Xinit>

```sh
USRRESOURCES=$HOME/.Xresources

USERXSESSION=$HOME/.xsession

USERXSESSIONRC=$HOME/.xsessionrc
```

e.g. `~/.xinitrc`:


```sh
xscreensaver &

exec openbox-session

# ^ start « xscreensaver » in the background, and THEN start « openbox ».
```

> Lines following a command using exec would be ignored. 

> Prepending exec will replace the script process with the window manager process, so that X does not exit even if this process forks to the background. 

> If you would like to remain logged in when the X session ends, remove exec.

### `/etc/xdg/xfce4/xinitrc`

```sh
#!/bin/sh

##################################################

# fix broken $UID on some system...

if test "x$UID" = "x"; then

  if test -x /usr/xpg4/bin/id; then
    UID=`/usr/xpg4/bin/id -u`;
  else
    UID=`id -u`;
  fi

fi

##################################################

# set $XDG_MENU_PREFIX to "xfce-" so that "xfce-applications.menu" is picked
# over "applications.menu" in all Xfce applications.

if test "x$XDG_MENU_PREFIX" = "x"; then

  XDG_MENU_PREFIX="xfce-"
  export XDG_MENU_PREFIX

fi

##################################################

# set DESKTOP_SESSION so that one can detect easily i an Xfce session is running

if test "x$DESKTOP_SESSION" = "x"; then

  DESKTOP_SESSION="xfce"
  export DESKTOP_SESSION

fi

##################################################

# set XDG_CURRENT_DESKTOP so that Qt 5 applications can identify user set Xfce theme

if test "x$XDG_CURRENT_DESKTOP" = "x"; then

  XDG_CURRENT_DESKTOP="XFCE"
  export XDG_CURRENT_DESKTOP

fi

##################################################

# $XDG_CONFIG_HOME defines the base directory relative to which user specific
# configuration files should be stored. If $XDG_CONFIG_HOME is either not set
# or empty, a default equal to $HOME/.config should be used.

if test "x$XDG_CONFIG_HOME" = "x" ; then

  XDG_CONFIG_HOME=$HOME/.config

fi

[ -d "$XDG_CONFIG_HOME" ] || mkdir "$XDG_CONFIG_HOME"

##################################################

# $XDG_CACHE_HOME defines the base directory relative to which user specific
# non-essential data files should be stored. If $XDG_CACHE_HOME is either not
# set or empty, a default equal to $HOME/.cache should be used.

if test "x$XDG_CACHE_HOME" = "x" ; then

  XDG_CACHE_HOME=$HOME/.cache

fi

[ -d "$XDG_CACHE_HOME" ] || mkdir "$XDG_CACHE_HOME"

##################################################

# set up XDG user directores.  see
# http://freedesktop.org/wiki/Software/xdg-user-dirs

if which xdg-user-dirs-update >/dev/null 2>&1; then

    xdg-user-dirs-update

fi

##################################################

BASEDIR="$XDG_CONFIG_HOME/xfce4"

# For now, start with an empty list

XRESOURCES=""

##################################################

# Has to go prior to merging Xft.xrdb, as its the "Defaults" file

test -r "/etc/xdg/xfce4/Xft.xrdb" && XRESOURCES="$XRESOURCES /etc/xdg/xfce4/Xft.xrdb"

test -r $HOME/.Xdefaults && XRESOURCES="$XRESOURCES $HOME/.Xdefaults"

##################################################

# merge in X cursor settings

test -r "$BASEDIR/Xcursor.xrdb" && XRESOURCES="$XRESOURCES $BASEDIR/Xcursor.xrdb"

##################################################

# ~/.Xresources contains overrides to the above

test -r "$HOME/.Xresources" && XRESOURCES="$XRESOURCES $HOME/.Xresources"

##################################################

# load all X resources (adds /dev/null to avoid an empty list that would hang the process)

cat /dev/null $XRESOURCES | xrdb -merge -

##################################################

# load local modmap

test -r $HOME/.Xmodmap && xmodmap $HOME/.Xmodmap

##################################################

# run xfce4-session if installed

if which xfce4-session >/dev/null 2>&1; then

  xfce4-session
  exit 0

fi

##################################################
```

NOTE:

« `test -r FILE` » means: `FILE` exists and read permission is granted.

> If you're not sure if you're using the session manager,
> type `ps -e | grep xfce4-session` in a terminal while Xfce is running.

`xfce4-session` itself calls:


```sh

##################################################

# start up stuff in $XDG_CONFIG_HOME/autostart/

if test -d "$XDG_CONFIG_HOME/autostart"; then
  for i in ${XDG_CONFIG_HOME}/autostart/*.desktop; do

    grep -q -E "^Hidden=true" "$i" && continue
    if grep -q -E "^OnlyShowIn=" "$i"; then
      # need to test twice, as lack of the line entirely means we still run it
      grep -E "^OnlyShowIn=" "$i" | grep -q 'XFCE;' || continue
    fi
    grep -E "^NotShowIn=" "$i" | grep -q 'XFCE;' && continue

    # check for TryExec

    trycmd=`grep -E "^TryExec=" "$i" | cut -d'=' -f2`
    if test "$trycmd"; then
      which "$trycmd" >/dev/null 2>&1 || continue
    fi

    cmd=`grep -E "^Exec=" "$i" | cut -d'=' -f2`
    if test "$cmd" && which "$cmd" >/dev/null 2>&1; then
      $cmd &
    fi

  done
fi

##################################################
```

## `XDG_CONFIG_HOME/cabal/config`

Same format as `.project` files.

The default (autogenerated by `cabal-install` 2.4.0.0) is:

```cabal
--------------------------------------------------

repository hackage.haskell.org
  url: http://hackage.haskell.org/
  -- secure: True
  -- root-keys:
  -- key-threshold: 3

--------------------------------------------------

-- default-user-config:
-- require-sandbox: False
-- ignore-sandbox: False
-- ignore-expiry: False
-- http-transport:
-- nix: False
remote-repo-cache: /home/sboo/.cabal/packages
-- local-repo:
-- logs-dir: /home/sboo/.cabal/logs
world-file: /home/sboo/.cabal/world
-- store-dir:
-- verbose: 1
-- compiler: ghc
-- cabal-file:
-- with-compiler:
-- with-hc-pkg:
-- program-prefix: 
-- program-suffix: 
-- library-vanilla: True
-- library-profiling:
-- shared:
-- static:
-- executable-dynamic: False
-- profiling:
-- executable-profiling:
-- profiling-detail:
-- library-profiling-detail:
-- optimization: True
-- debug-info: False
-- library-for-ghci:
-- split-sections: False
-- split-objs: False
-- executable-stripping: True
-- library-stripping: True
-- configure-option:
-- user-install: True
-- package-db:
-- flags:
-- extra-include-dirs:
-- deterministic:
-- cid:
-- extra-lib-dirs:
-- extra-framework-dirs:
extra-prog-path: /home/sboo/.cabal/bin
-- instantiate-with:
-- tests: False
-- coverage: False
-- library-coverage:
-- exact-configuration: False
-- benchmarks: False
-- relocatable: False
-- response-files:
-- cabal-lib-version:
-- constraint:
-- preference:
-- solver: modular
-- allow-older: False
-- allow-newer: False
-- documentation: False
-- doc-index-file: $datadir/doc/$arch-$os-$compiler/index.html
-- target-package-db:
-- max-backjumps: 2000
-- reorder-goals: False
-- count-conflicts: True
-- independent-goals: False
-- shadow-installed-packages: False
-- strong-flags: False
-- allow-boot-library-installs: False
-- reinstall: False
-- avoid-reinstalls: False
-- force-reinstalls: False
-- upgrade-dependencies: False
-- index-state:
-- root-cmd:
symlink-bindir: /home/sboo/.cabal/bin
build-summary: /home/sboo/.cabal/logs/build.log
-- build-log:
remote-build-reporting: anonymous
-- report-planning-failure: False
-- per-component: True
-- one-shot: False
-- run-tests:
jobs: $ncpus
-- keep-going: False
-- offline: False
-- project-file:
-- username:
-- password:
-- password-command:
-- builddir:

--------------------------------------------------

haddock
  -- keep-temp-files: False
  -- hoogle: False
  -- html: False
  -- html-location:
  -- executables: False
  -- tests: False
  -- benchmarks: False
  -- foreign-libraries: False
  -- all:
  -- internal: False
  -- css:
  -- hyperlink-source: False
  -- quickjump: False
  -- hscolour-css:
  -- contents-location:

--------------------------------------------------

install-dirs user
  -- prefix: /home/sboo/.cabal
  -- bindir: $prefix/bin
  -- libdir: $prefix/lib
  -- libsubdir: $abi/$libname
  -- dynlibdir: $libdir/$abi
  -- libexecdir: $prefix/libexec
  -- libexecsubdir: $abi/$pkgid
  -- datadir: $prefix/share
  -- datasubdir: $abi/$pkgid
  -- docdir: $datadir/doc/$abi/$pkgid
  -- htmldir: $docdir/html
  -- haddockdir: $htmldir
  -- sysconfdir: $prefix/etc

--------------------------------------------------

install-dirs global
  -- prefix: /usr/local
  -- bindir: $prefix/bin
  -- libdir: $prefix/lib
  -- libsubdir: $abi/$libname
  -- dynlibdir: $libdir/$abi
  -- libexecdir: $prefix/libexec
  -- libexecsubdir: $abi/$pkgid
  -- datadir: $prefix/share
  -- datasubdir: $abi/$pkgid
  -- docdir: $datadir/doc/$abi/$pkgid
  -- htmldir: $docdir/html
  -- haddockdir: $htmldir
  -- sysconfdir: $prefix/etc

--------------------------------------------------

program-locations
  -- alex-location:
  -- ar-location:
  -- c2hs-location:
  -- cpphs-location:
  -- doctest-location:
  -- gcc-location:
  -- ghc-location:
  -- ghc-pkg-location:
  -- ghcjs-location:
  -- ghcjs-pkg-location:
  -- greencard-location:
  -- haddock-location:
  -- happy-location:
  -- haskell-suite-location:
  -- haskell-suite-pkg-location:
  -- hmake-location:
  -- hpc-location:
  -- hsc2hs-location:
  -- hscolour-location:
  -- jhc-location:
  -- ld-location:
  -- pkg-config-location:
  -- runghc-location:
  -- strip-location:
  -- tar-location:
  -- uhc-location:

--------------------------------------------------

program-default-options
  -- alex-options:
  -- ar-options:
  -- c2hs-options:
  -- cpphs-options:
  -- doctest-options:
  -- gcc-options:
  -- ghc-options:
  -- ghc-pkg-options:
  -- ghcjs-options:
  -- ghcjs-pkg-options:
  -- greencard-options:
  -- haddock-options:
  -- happy-options:
  -- haskell-suite-options:
  -- haskell-suite-pkg-options:
  -- hmake-options:
  -- hpc-options:
  -- hsc2hs-options:
  -- hscolour-options:
  -- jhc-options:
  -- ld-options:
  -- pkg-config-options:
  -- runghc-options:
  -- strip-options:
  -- tar-options:
  -- uhc-options:

--------------------------------------------------
```

## `autoconf`

e.g. a fragment:

```ac

# FIXME: Replace `main' with a function in `-lGL':
AC_CHECK_LIB([GL], [main])
# FIXME: Replace `main' with a function in `-lGLU':
AC_CHECK_LIB([GLU], [main])
# FIXME: Replace `main' with a function in `-lX11':
AC_CHECK_LIB([X11], [main])
# FIXME: Replace `main' with a function in `-lXext':
AC_CHECK_LIB([Xext], [main])
# FIXME: Replace `main' with a function in `-lXft':
AC_CHECK_LIB([Xft], [main])
# FIXME: Replace `main' with a function in `-lXinerama':
AC_CHECK_LIB([Xinerama], [main])
# FIXME: Replace `main' with a function in `-ldl':
AC_CHECK_LIB([dl], [main])
# FIXME: Replace `main' with a function in `-lfltk':
AC_CHECK_LIB([fltk], [main])
# FIXME: Replace `main' with a function in `-lfltk_gl':
AC_CHECK_LIB([fltk_gl], [main])
# FIXME: Replace `main' with a function in `-lfltk_images':
AC_CHECK_LIB([fltk_images], [main])
# FIXME: Replace `main' with a function in `-lfontconfig':
AC_CHECK_LIB([fontconfig], [main])
# FIXME: Replace `main' with a function in `-ljpeg':
AC_CHECK_LIB([jpeg], [main])
# FIXME: Replace `main' with a function in `-lm':
AC_CHECK_LIB([m], [main])
# FIXME: Replace `main' with a function in `-lpng':
AC_CHECK_LIB([png], [main])
# FIXME: Replace `main' with a function in `-lpthread':
AC_CHECK_LIB([pthread], [main])
# FIXME: Replace `main' with a function in `-lz':
AC_CHECK_LIB([zlib], [main])
```

## `git submodule`

```sh
git submodule init
git submodule update
git submodule add    -b       release-18.09
git submodule update --remote
```

track a tag within a submodule (e.g. `remotes/origin/release-18.09`):

```sh
$ git branch -a
* master
  remotes/origin/master
  ...
  remotes/origin/release-18.09
  
$ git reset --hard release-18.09
Error: unknown revision or path

$ git fetch --tags origin release-18.09:release-18.09 
 * [new branch]      release-18.09 -> release-18.09

$ git checkout release-18.09

$ git branch -a
  master
* release-18.09
  remotes/origin/master
  ...
  remotes/origin/release-18.09

```

## `grep`


```man
$ grep --help 

Usage: grep [OPTION]... PATTERN [FILE]...

Search for PATTERN in each FILE or standard input.

PATTERN is, by default, a basic regular expression (BRE).

Example: grep -i 'hello world' menu.h main.c

  -E, --extended-regexp     PATTERN is an extended regular expression (ERE)
  -F, --fixed-strings       PATTERN is a set of newline-separated strings
  -G, --basic-regexp        PATTERN is a basic regular expression (BRE)
  -P, --perl-regexp         PATTERN is a Perl regular expression

  -f, --file=FILE           obtain PATTERN from FILE
  -r, --recursive           like --directories=recurse
  -R, --dereference-recursive  likewise, but follow all symlinks

  -i, --ignore-case         ignore case distinctions
  -w, --word-regexp         force PATTERN to match only whole words
  -x, --line-regexp         force PATTERN to match only whole lines

  -l, --files-with-matches  print only names of FILEs containing matches
      --color[=WHEN],
      --colour[=WHEN]       use markers to highlight the matching strings;
                            WHEN is 'always', 'never', or 'auto'

  -v, --invert-match        select non-matching lines
```

```sh
```

## `fltk` dependencies via `nix`

e.g.:

```
  /nix/store/6m54pia6wmc7bqp8d3n2vc1y5zpwa50x-fontconfig-2.12.6.tar.bz2
  /nix/store/8va3grszpm0dl7x6qkygqkvrfcgk5gjd-openssl-1.0.2p.tar.gz
  /nix/store/amwvfrpyj7wsin337l7rsa1sghiwh9yg-libjpeg-turbo-1.5.3.tar.gz
  /nix/store/c9i9ls6xm6jxsmd7gxf46dz7s9d9ga55-libXext-1.3.3.tar.bz2
  /nix/store/ghd006s9ssci1s6vqz01hf379dxzcby9-fltk-1.3.4-source.tar.gz
  /nix/store/glnk048cqva0ig8yrjfw140z2r2v18b4-stdenv-linux
  /nix/store/k6ihv2lh5czvam355r93dl1zw5pn7dsj-freeglut-3.0.0.tar.gz
  /nix/store/lbd3i8bpm9y5pf2nbjcd81lk5jqrnn7v-flac-1.3.2.tar.xz
  /nix/store/mji9isc0n4b0dsx2ykyw79ri7lvmr0cf-libXft-2.3.2.tar.bz2
  /nix/store/nmizffdcmizgflkmhn8yr3zvw2g1q1hx-libX11-1.6.6.tar.bz2
  /nix/store/nn1ci56h0q4iwp28sjdpd26y159da28s-libpng-1.6.34.tar.xz
  /nix/store/qwqiq956mf0r28szgh22sfbx1wmhl100-libXinerama-1.1.4.tar.bz2
  /nix/store/rrzja19jbqxbfryp2zchb2ma5h041rxh-zlib-1.2.11.tar.gz
```

## Home-Manager `fontconfig`

<https://github.com/rycee/home-manager/blob/release-18.09/modules/misc/fontconfig.nix>

Signature:

`fonts.fontconfig.enableProfileFonts`

> Configure fontconfig to discover fonts installed through home.packages and nix-env.
> Note, this is only necessary on non-NixOS systems. 
    
Definition:

```
    xdg.configFile."fontconfig/conf.d/10-nix-profile-fonts.conf".text = ''

      <?xml version='1.0'?>
      <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>

      <fontconfig>
        <dir>${config.home.profileDirectory}/lib/X11/fonts</dir>
        <dir>${config.home.profileDirectory}/share/fonts</dir>
      </fontconfig>

    '';
```

