# Dictation


## Files


* <<./scripts/add-user.sh>> — register your `$USER` under VirtualBox `group`s.


## the `TableMike`

a.k.a. the `SpeechWare USB 6-in-1 TableMike`

by `SpeechWare`.

### `TableMike` on the Host

Audio Settings > Capture Devices > ...
Microphone (USB TableMike Analog Mono)
Internal Microphone (Built-In Audio Analog Stereo)

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




### `lsusb`

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

## `VirtualBox`

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

$ cat /etc/group | grep vbox | grep "$USER" | wc -l

2
```

### VirtualBox's USB Support


```sh
$ VBoxManage list usbhost

Host USB Devices:

<none>
```




### 














## 




## 




## 