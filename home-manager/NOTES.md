# Notes

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

## 

