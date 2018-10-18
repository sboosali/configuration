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

## 

