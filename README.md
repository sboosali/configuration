# Configuration

My personal configuration (dotfiles, etc)

Uses `nix`.


## Files

* `./home-manager/nix/**/*.nix` — my `home-manager`
* `./archives/...` — backup `home-manager` generations (snapshots)
* `./dictation/...` — Notes about Dictation & Instructions for configuring microphones and for installing `Dragon NaturallySpeaking` 15 within a `Windows 10` virtual-machine via `VirtualBox`
* TODO


## Usage

### TODO Startup Scripts

For startup of the system, the display, a terminal, etc. 



## Setup

### get `nix`

    curl https://nixos.org/nix/install | sh


### installation of dependencies (via `nix`)

TODO

    # nix-build configuration.nix
    nix-env -i configuration.nix

### `~/.config/`

Symlink some `~/.config` subdirs from `./config/...`'.

### 'ln -s` symlinks

this

    ./compile-dhall-configuration.sh -f

converts the .dhall to a .sh script and executes it.

in particular, it symlinks everything into this (version controlled) directory, like:

    /home/sboo/.bashrc  ->  /home/sboo/configuration/bash/.bashrc
    ...

it takes a single optional argument, which is passes onto `ln`. for example, this is a safer version that doesn't overwrite anything:

    ./compile-dhall-configuration.sh

### `cp` directly

    ./reconfigure-privileged.sh

    ./configuration-cp.sh


## Dependencies

TODO

see `TODO.nix`


## Installation

Scripts for installaling, upgrading, and bootstrapping: TODO

## VirtualBox

### Register a `.vbox` via `VBoxManage`

```
VBoxManage registervm /full/path/to/ExampleMachine.vbox
```

### Import an `.ova` via `VBoxManage`

```
VBoxManage import /full/path/to/ExampleArchive.ova
```

e.g. my Windows VM with Dragon NaturallySpeaking installed:

```
$ time VBoxManage import "~/media/blobs/Windows10_DNS15.ova"

...

Disks:

  vmdisk1	34359738368	-1	http://www.vmware.com/interfaces/specifications/vmdk.html#streamOptimized	Windows10_DNS15-disk001.vmdk	-1	-1	

...

Virtual system 0:

 0: Suggested OS type: "Windows10_64"

    (change with "--vsys 0 --ostype <type>"; use "list ostypes" to list all possible values)

 1: Suggested VM name "Windows10_DNS15"

    (change with "--vsys 0 --vmname <name>")

 2: Number of CPUs: 1

    (change with "--vsys 0 --cpus <n>")

 3: Guest memory: 6000 MB

    (change with "--vsys 0 --memory <MB>")

 4: Sound card (appliance expects "", can change on import)

    (disable with "--vsys 0 --unit 4 --ignore")

 5: USB controller

    (disable with "--vsys 0 --unit 5 --ignore")

 6: Network adapter: orig NAT, config 3, extra slot=0;type=NAT

 7: CD-ROM

    (disable with "--vsys 0 --unit 7 --ignore")

 8: SATA controller, type AHCI

    (disable with "--vsys 0 --unit 8 --ignore")

 9: Hard disk image: source image=Windows10_DNS15-disk001.vmdk, target path=/home/sboo/VirtualBox VMs/Windows10_DNS15/Windows10_DNS15-disk001_1.vmdk, controller=8;channel=0

    (change target path with "--vsys 0 --unit 9 --disk path";
    disable with "--vsys 0 --unit 9 --ignore")

...

Successfully imported the appliance.

real	1m26s
```

### List imported/registered virtual machines

```
VBoxManage list vms
```

syntactically:

```
$ VBoxManage list vms

"VM Name" {VM-UUID}
```

e.g. Windows/Dragon VM (installed above):

```
$ VBoxManage list vms

"Windows10_DNS15" {c8ae145a-bf98-440e-8e6e-c30e015d499f}
```

### Open a virtual machine (by name)

```
VBoxManage  "${YourVirtualMachineName}"
```

e.g. Windows/Dragon VM (installed above):

```
$ VBoxManage "Windows10_DNS15"
```

### Query a virtual machine for status/settings (by name)

```
VBoxManage showvminfo <UUID|VMName> [--details] [--machinereadable]
```

See the Manual:

```
$ man VBoxManage

...
    showvminfo <uuid|vmname> [--details] [--machinereadable]
...
```

e.g. Windows/Dragon VM (installed above):

```sh
$ VBoxManage showvminfo "Windows10_DNS15" --details --machinereadable
```

displays (most lines ommitted for concision):

```conf
name                            = "Windows10_DNS15"
UUID                            = "c8ae145a-bf98-440e-8e6e-c30e015d499f"

ostype                          = "Windows 10 (64-bit)"

cpus                            = 1                                             # one CPU
cpuexecutioncap                 = 100                                           # uncapped (100% cap)

memory                          = 6000                                          # 6.000 GiB of RAM (6000 MiB)

vram                            = 128                                           # 128 MiB of Video RAM

groups                          = "/"

CfgFile                         = "/home/sboo/VirtualBox VMs/Windows10_DNS15/Windows10_DNS15.vbox"
SnapFldr                        = "/home/sboo/VirtualBox VMs/Windows10_DNS15/Snapshots"

firmware                        = "BIOS"
apic                            = "on"
bootmenu                        = "messageandmenu"
acpi                            = "on"

VMState                         = "poweroff"
VMStateChangeTime               = "2017-12-08T20:13:43.000000000"

monitorcount                    = 1

accelerate3d                    = "off"
accelerate2dvideo               = "off"

autostart-enabled               = "off"
autostart-delay                 = 0

defaultfrontend                 = ""                                            # TODO no default? a Frontend means...?

storagecontrollername0          = "SATA"
storagecontrollertype0          = "IntelAhci"
storagecontrollerbootable0      = "on"
"SATA-0-0"                      = "/home/sboo/VirtualBox VMs/Windows10_DNS15/Windows10_DNS15-disk001.vmdk"
"SATA-ImageUUID-0-0"            = "95f30ef5-52b7-4069-8226-458f65a9af2f"
"SATA-1-0"                      = "emptydrive"
"SATA-IsEjected"                = "off"

natnet1                         = "nat"
macaddress1                     = "080027552F5D"
cableconnected1                 = "on"

nic1                            = "nat"                                         # NAT abbreviates "Network Address Translation"
nic2                            = "none"                                        # (no other Network Interface Controllers)
nic3                            = "none"
nic4                            = "none"
nic5                            = "none"
nic6                            = "none"
nic7                            = "none"
nic8                            = "none"

hidpointing                     = "usbtablet"
hidkeyboard                     = "ps2kbd"                                      # the Keyboard is "PS/2" (i.e. the standard one)

audio                           = "pulse"

clipboard                       = "bidirectional"
draganddrop                     = "bidirectional"

usb                             = "on"

SharedFolderNameMachineMapping1 = "Host_Windows"
SharedFolderPathMachineMapping1 = "C:\Users\Spiros\Guest_Windows"

...
```

or:

```
$ VBoxManage showvminfo "Windows10_DNS15" --details > ./virtualbox/data/showvminfo__Windows10_DNS15__human-readable.txt
```

See [showvminfo__Windows10_DNS15__machine-readable.conf](./virtualbox/data/showvminfo__Windows10_DNS15__machine-readable.conf).

NOTE:

> Network address translation (NAT) is a method of remapping one IP address space into another by modifying network address information in the IP header of packets while they are in transit across a traffic routing device.

### Startup a virtual machine (by name)

```man
startvm <uuid|vmname> [--type gui|sdl|headless|separate]
```

e.g. Windows/Dragon VM (installed above):

```sh
VBoxManage startvm "Windows10_DNS15" --type gui
```

### Manipulate a virtual machine (by name)

```man
controlvm <uuid|vmname> (pause | resume | reset | poweroff | savestate | acpipowerbutton | acpisleepbutton | keyboardputscancode <hex>+)

```

### Take Snapshots of a virtual machine (by name)

e.g. Windows/Dragon VM (installed above):

```sh
VBoxManage controlvm "Windows10_DNS15" savestate
```

e.g. backup a running virtual machine hourly:

```sh
TODO while 1; do VBoxManage controlvm "Windows10_DNS15" savestate; sleep 3600; done
```

### Shutdown a virtual machine (by name)

e.g. Windows/Dragon VM (installed above)...

* Shut it down:

```sh
VBoxManage controlvm "Windows10_DNS15" poweroff
```

* Pause it:

```sh
VBoxManage controlvm "Windows10_DNS15" pause
```

* Un-Pause it:

```sh
VBoxManage controlvm "Windows10_DNS15" resume
```

* Shut it down (#1):

```sh
VBoxManage controlvm "Windows10_DNS15" poweroff
```

* Shut it down (#2):

```sh
VBoxManage controlvm "Windows10_DNS15" acpipowerbutton
```

### "Send" keypresses to a virtual machine (TODO or simulate keypresses within it?)

```man
controlvm <uuid|vmname> (pause | resume | reset | poweroff | savestate | acpipowerbutton | acpisleepbutton | keyboardputscancode <hex>+)

```

e.g. Windows/Dragon VM (installed above):

```sh
VBoxManage controlvm "Windows10_DNS15" keyboardputscancode TODO
```

### Importing an Existing Virtual Machine into VirtualBox (via `virtualbox` GUI)

<https://docs.oracle.com/cd/E26217_01/E26796/html/qs-import-vm.html>

