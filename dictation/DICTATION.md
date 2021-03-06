# Dictation

Personal notes about:

- `Dragon NaturallySpeaking` — (and *Speech Recognition* in general).
- `VirtualBox`               — (and *Virtual Machines*, in general).
- `Windows`                  — as a *Guest Machine*.
- `Linux`                    — as the *Host Machine*. (and Host *Operating Systems*, in general, like *MacOS*).

## Files

* `./vocabulary.txt`      — list of words/phrases (one-per-line) to import into DragonNaturallySpeaking
* `./scripts/add-user.sh` — register `$USER` under VirtualBox `group`s.
* `./MW*Installer.exe`  — Installer for *MacroWorks*. (from <https://xkeys.com/pub/media/wysiwyg/smartwave/porto/category/FileDownloads/MW3.1(1.1.2.06)Installer.exe>)



## Configuration

Configuring the *Guest Virtual Machine*:

* *Windows* configuration:

    - enable **Sticky Keys*
    - verify the *Local Network* (i.e. can the Guest and Host communicate?). 
      otherwise, disable the *Windows Firewall*.

* *VirtualBox* configuration:

    - install *Guest Additions*
    - register a *Shared Folder*
    - verify the *Audio Driver* (the default, *ALSA*, works for me). 
    - passthru the *TableMike* USB Recording Device

* *Dragon NaturallySpeaking* configuration:

    - install *Dragon NaturallySpeaking v15* 
    - create a *User Profile*
    - 


## `Dragon NaturallySpeaking`

"C:\Program Files (x86)\Nuance\NaturallySpeaking15\Program\"

### `Dragon NaturallySpeaking` Files

the `Dragon NaturallySpeaking` executeable (for `DNS v15` on *Windows 10*) is at `"C:\Program Files (x86)\Nuance\NaturallySpeaking15\Program\natspeak.exe"`.

### Autostart `Dragon NaturallySpeaking`

the `shell:startup` command launches the *Autostart Directory*.

Create an *Application Shortcut* (e.g. `"C:\Program Files (x86)\Nuance\NaturallySpeaking15\Program\natspeak.exe"`) in the *Autostart Directory* (e.g. `"C:\Users\VirtualSpiros\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"`).



## Windows

### Enable *Sticky Keys*

Enable *Sticky Keys*:

- type `sticky keys` in the *Search Bar*.

Configure *Sticky Keys*:

Navigate to the `Control Panel\Ease of Access\Ease of Access Center\Set up Sticky Keys` menu.



## `VirtualBox`

### Installing `VirtualBox`

1. On the host (via `apt` on Ubuntu):

    ```
    $ sudo apt install -y virtualbox-guest-additions-iso
    $ ls /usr/share/virtualbox/VBoxGuestAdditions.iso
    ```

2. Drag-n-drop the `.iso` from the host (via a *File Explorer*) to the guest (e.g. onto the Desktop):

3. On the guest (on Windows):

    - double-click on the `.iso` (to extract it).
    - double-click on an `.exe` (to install it), for example `VBoxGuestAdditions-amd64.exe` (for a `x86_64-linux` host).
    - reboot.

### `VirtualBox` groups

`vbox*` groups include:

* `vboxsf` — permits mounting of Shared Folders.
* `vboxusers` — permits passing USB Devices through, from the Host to any Guests.

NOTE add your User as a member of the `vbox*` Groups (or ensure your User is already a member).

e.g. before membership:

```sh
$ cat /etc/group | grep vbox

vboxusers:x:130:
vboxsf:x:131:
```

e.g. add membership (for my User, i.e. `sboo`):

```sh
$ sudo usermod -aG vboxusers "$USER"
$ sudo usermod -aG vboxsf    "$USER"

# then « reboot » or « logout/login » (if necessary).
```

e.g. after membership:

```sh
$ cat /etc/group | grep vbox

vboxusers:x:130:sboo
vboxsf:x:131:sboo

$ cat /etc/group | grep'^vbox' | grep "$USER"\$ |  cut -d ':' -f1

vboxusers
vboxsf

$ cat /etc/group | grep vbox | grep "$USER" | wc -l

2
```

### VirtualBox's *Shared Folder* Support

to register a Shared Folder on a Windows Guest, e.g. for a Shared Folder named `Host`, run `use` (in `CMD.exe`):

e.g. Success:

``` bat
> net use x: \\vboxsvr\Host

The command completed successfully.
```

e.g. Failure:

``` bat
> net use x: \\vboxsvr\Host

System error 53 has occurred.

The network path was not found.
```

e.g. Failure:

``` bat
> net use x: \\vboxsvr\Host

System error 69 has occurred.

The network name was not found.
```

Troubleshooting:

* Disable the *(Windows) Firewall* (on the Windows Guest).
* Re-Install the *VirtualBox Guest Additions*.
* Discover the Shared Folder name:

    - e.g. `Host` if created by an invocation of this command: `$ VBoxManage sharedfolder add "Windows10Dragon15" -name "Host" -hostpath "~/guests/Windows10Dragon15"`
    - e.g. In the *VirtualBox GUI*, for a Virtual Machine named *Windows10Dragon15*, click `Shared Folders > Folders List > Machine Folders`, then read the `Name` (leftmost) column.

When simultaneously editing *Shared Files*, set the *Line-Ending Convention* to *"\r"*:

- On the Guest, with *Notepad.exe* — which `Dragon NaturallySpeaking` supports natively.
- On the Host, with *Emacs* — which can save File Buffers in Windows' Line-Ending Convention via `M-x set-buffer-file-coding-system RET dos RET` (i.e. `M-: (set-buffer-file-coding-system 'dos)`).

### VirtualBox's *Audio*

#### Troubleshooting

<https://stackoverflow.com/questions/28134018/microphone-in-windows-10-in-virtualbox>

__PROBLEM:__ *Builtin Microphone doesn't work, in Windows 10, under VirtualBox.*

__SOLUTION:__

 1. In VirtualBox open the settings for your Windows 10 machine
 2. Go to Audio > Audio Controller, change to "ICH AC97"
 3. [Boot your Windows 10 machine and disable driver signature enforcement][2]
 4. Go to [Realtek's website][1], download and install the AC'97 audio codec/driver for Vista/7 ("Vista/Win7 (32/64 bits) Driver only (ZIP file)") onto your Windows 10 machine (run setup.exe after unzipping)
 5. Reboot Windows 10 and you should be done


  [1]: https://www.realtek.com/en/component/zoo/category/pc-audio-codecs-ac-97-audio-codecs-software
  [2]: http://www.howtogeek.com/167723/how-to-disable-driver-signature-verification-on-64-bit-windows-8.1-so-that-you-can-install-unsigned-drivers/

### VirtualBox's *USB* Support

e.g. before setup:

```sh
$ VBoxManage list usbhost

Host USB Devices:

<none>
```

e.g. after setup:

```sh
$ VBoxManage list usbhost

Host USB Devices:

UUID:               7f019d5c-abd5-455a-a765-4f064fd3f541
VendorId:           0x8c00 (8C00)
ProductId:          0x3c00 (3C00)
Revision:           1.0 (0100)
Port:               0
USB version/speed:  1/Full
Manufacturer:       C-Media Electronics Inc.      
Product:            USB TableMike
Address:            sysfs:/sys/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1.1//device:/dev/vboxusb/001/004
Current State:      Busy

UUID:               5acda71f-cb35-4d0c-8d68-e99c0ff09a86
VendorId:           0x1125 (1125)
ProductId:          0x1807 (1807)
Revision:           0.0 (0000)
Port:               1
USB version/speed:  1/Low
Manufacturer:       Genovation Inc
Product:            ControlPad24
Address:            sysfs:/sys/devices/pci0000:00/0000:00:14.0/usb1/1-2//device:/dev/vboxusb/001/024
Current State:      Busy

UUID:               69242917-5c10-4f49-9e4b-1609e8b2b0da
VendorId:           0x058f (058F)
ProductId:          0x6366 (6366)
Revision:           1.0 (0100)
Port:               3
USB version/speed:  2/High
Manufacturer:       Generic
Product:            Mass Storage Device
SerialNumber:       058F0O1111B1
Address:            sysfs:/sys/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1.4//device:/dev/vboxusb/001/006
Current State:      Busy

UUID:               c0f34417-00a8-4a33-828c-84132c0efe30
VendorId:           0x04f3 (04F3)
ProductId:          0x24a0 (24A0)
Revision:           17.17 (1717)
Port:               8
USB version/speed:  2/Full
Manufacturer:       ELAN
Product:            Touchscreen
Address:            sysfs:/sys/devices/pci0000:00/0000:00:14.0/usb1/1-9//device:/dev/vboxusb/001/005
Current State:      Busy
```



## Vocabulary

### creating `vocabulary.txt`

1. get my code files, including:

    * `*.hs` — Haskell files
    * `*.el` — Elisp files
    * `*.nix` — Nix files
    * `*.sh` — Shell scripts
    * `*.` — 
    * `*.` — 

2. strip — strip out comments (i.e. only keep the code). 
3. tokenize — split into words. remove symbols, or "pronounce" them (e.g. `<*>` becomes `apply`, `<*>\apply` in Natlink's syntax).

via:

    find -L ~/haskell -type f -name '*.hs' -print 2> /dev/null

for parsing haskell:

* `haskell-src-meta`, `haskell-src-exts`

### importing `vocabulary.txt`

click `Add Document`, select these settings:

* ✓ `new words`
* ✓ `new capitalization`
* ❌ `match style`

## the `TableMike`

a.k.a. the `SpeechWare USB 6-in-1 TableMike`

by `SpeechWare`.

### `TableMike` on the Host

VirtualBox Menu:

```
Audio Settings > Capture Devices > Microphone (USB TableMike Analog Mono)
Audio Settings > Capture Devices > Internal Microphone (Built-In Audio Analog Stereo)
```

### `TableMike` on the Guest

Create *USB Filters* for:

* the `Alcor Micro Corp. USB Hub` (arbitrarily named `"TableMike Hub"`):

    * `VendorID`     — 058f
    * `ProductID`    — 6254
    * `Revision`     —
    * `Manufacturer` —
    * `Product`      —
    * `SerialNumber` —
    * `Port`         — 

* the `Alcor Micro Corp. Multi Flash Reader` (arbitrarily named `"TableMike Storage"`):

    * `VendorID`     — 058f
    * `ProductID`    — 6366
    * `Revision`     —
    * `Manufacturer` —
    * `Product`      —
    * `SerialNumber` —
    * `Port`         — 

* the (arbitrarily named `"TableMike TODO"`):

    * `VendorID`     — 8c00
    * `ProductID`    — 3c00
    * `Revision`     —
    * `Manufacturer` —
    * `Product`      —
    * `SerialNumber` —
    * `Port`         — 

where the data came from `lsusb -v`.

### `lsusb` & the `TableMike`

```sh
$ lsusb
...
Bus 001 Device 023: ID 058f:6366 Alcor Micro Corp. Multi Flash Reader
Bus 001 Device 022: ID 8c00:3c00  
Bus 001 Device 021: ID 058f:6254 Alcor Micro Corp. USB Hub
...
```

```sh
$ lsusb -v -d 8c00:3c00

Bus 001 Device 022: ID 8c00:3c00

Device Descriptor:
  ...
  bcdUSB               1.10
  ...
  idVendor           0x8c00 
  idProduct          0x3c00 
  ...
  iManufacturer           1    (C-Media Electronics Inc.)
  iProduct                2    (USB TableMike)
  ...

  Configuration Descriptor:
    ...
    bNumInterfaces          4
    bmAttributes         0x80  (Bus Powered)
    ...
    MaxPower              500mA
    ...

    Interface Descriptor:
      ...
      bInterfaceNumber        0
      ...
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      ...

      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 

      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             1
        wChannelConfig     0x0001
          Left Front (L)
        iChannelNames           0 
        iTerminal               0 

    ...

      AudioControl Interface Descriptor:
        ...
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        ...
        bmaControls( 0)      0x01
          Mute Control
        bmaControls( 1)      0x02
          Volume Control
        bmaControls( 2)      0x02
          Volume Control
        ...

      AudioControl Interface Descriptor:
        ...
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        ...
        bmaControls( 0)      0x43
          Mute Control
          Volume Control
          Automatic Gain Control
        bmaControls( 1)      0x00
        ...

    ...

    Interface Descriptor:
      ...
      bInterfaceNumber        3
      bInterfaceClass         _ (Human Interface Device)
      ...
      bNumEndpoints           1
      ...

      Endpoint Descriptor:
        ...
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               2
```



```sh
$ lsusb -v -d 058f:6254

```

```sh
$ lsusb -v -d 058f:6366

```

### 



## `Genovation` `ControlPad`

### `lsusb` & the `ControlPad`

Invoking `lsusb -v` upon a `CP24` in "Keyboard Mode" outputs:

> Bus 001 Device 007: ID 1125:1807
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0 
>   bDeviceProtocol         0 
>   bMaxPacketSize0         8
>   idVendor           0x1125 
>   idProduct          0x1807 
>   bcdDevice            0.00
>   iManufacturer           1 Genovation Inc
>   iProduct                2 ControlPad24
>   iSerial                 0 
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           59
>     bNumInterfaces          2
>     bConfigurationValue     1
>     iConfiguration          0 
>     bmAttributes         0xa0
>       (Bus Powered)
>       Remote Wakeup
>     MaxPower              100mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      1 Boot Interface Subclass
>       bInterfaceProtocol      1 Keyboard
>       iInterface              0 
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.10
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      73
>          Report Descriptors: 
>            ** UNAVAILABLE **
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0008  1x 8 bytes
>         bInterval              10
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      0 No Subclass
>       bInterfaceProtocol      0 None
>       iInterface              0 
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.10
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      25
>          Report Descriptors: 
>            ** UNAVAILABLE **
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0008  1x 8 bytes
>         bInterval              10
> Device Status:     0x0000
>   (Bus Powered)

Invoking `lsusb -v` upon a `CP24` in "USB Mode" outputs:

> Bus 001 Device 009: ID 1125:1803
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0 
>   bDeviceProtocol         0 
>   bMaxPacketSize0        64
>   idVendor           0x1125 
>   idProduct          0x1803 
>   bcdDevice            0.00
>   iManufacturer           1 Genovation
>   iProduct                2 ControlPad-MSD
>   iSerial                 3 000100010003
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           32
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0 
>     bmAttributes         0x80
>       (Bus Powered)
>     MaxPower              100mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass         8 Mass Storage
>       bInterfaceSubClass      6 SCSI
>       bInterfaceProtocol     80 Bulk-Only
>       iInterface              0 
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x02  EP 2 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               0
> Device Status:     0x0000
>   (Bus Powered)

### Troubleshooting the `ControlPad`

If the `ControlPad` doesn't work or doesn't mount...

### Troubleshooting: `ControlPad` in "USB Mode" won't mount

Find the device:

```sh
$ readlink -f /dev/disk/by-label/CONTROLPAD

/dev/sdb
```

Create a "Mount Point":

```sh
$ sudo mkdir /media/sboo/CONTROLPAD
```

Mount the device (onto the "Mount Point"):

```sh
$ sudo mount /dev/disk/by-label/CONTROLPAD /media/sboo/CONTROLPAD
```

Enter the "Mount Point":

```sh
$ find /media/sboo/CONTROLPAD

/media/sboo/CONTROLPAD/System Volume Information/WPSettings.dat
/media/sboo/CONTROLPAD/System Volume Information/IndexerVolumeGuid

$ cd /media/sboo/CONTROLPAD
```

## `XK-68 Jog & Shuttle`

1. Install *Microsoft .NET Framework 3.5.1* (*Service Pack*).
1. Install *MacroWorks 3.1* (*Application*).
1. Configure `XK-68 Jog & Shuttle` via *MacroWorks*.


### `MW3.exe`

Configure *XKeys Devices* on *Windows* via *MacroWorks* (fetch from <http://xkeys.com/PISupport/SoftwareMacroWorks.php>).

the `MW3.exe` executable requires the *Microsoft .NET Framework 3.5 SP1* Service Pack (fetch from <https://download.microsoft.com/download/2/0/E/20E90413-712F-438C-988E-FDAA79A8AC3D/dotnetfx35.exe>).

## Emacs




















## 