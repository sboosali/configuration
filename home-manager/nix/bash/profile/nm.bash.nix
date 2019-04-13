##################################################
{ pkgs
, xdg
}:

# Network-specific Initialization

##################################################
let
#-----------------------------------------------#

#-----------------------------------------------#
in
##################################################

''
#-----------------------------------------------#
# Network Manager ------------------------------#
#-----------------------------------------------#


''
#------------------------------------------------#
# Notes -----------------------------------------#
#------------------------------------------------#
/*
#------------------------------------------------#

« nmcli »:

$ nmcli wifi devices

  ∅

# originally...

$ nmcli devices

  DEVICE           TYPE      STATE         CONNECTION 
  enxa44cc89c79ed  ethernet  disconnected  --         
  lo               loopback  unmanaged     --         

$ nmcli connection show

  NAME                UUID                                  TYPE             DEVICE 
  Grotto              13088187-1995-41f7-9b00-3d2e3788001e  802-11-wireless  --     
  Grotto-EXT          5ba5def7-f668-49e4-a779-ba4eb5e73200  802-11-wireless  --     
  GrottoExt(2G)       75eeeaf2-cb41-4e94-9525-60631fc0be6c  802-11-wireless  --     
  Wired connection 1  59af1fa9-750e-3ca0-9e74-bae5163b62ea  802-3-ethernet   --     
  ZK27B               39506dd8-2e21-4a44-ad1a-aa9fd1b4ba72  802-11-wireless  --     

$ nmcli connection up uuid 59af1fa9-750e-3ca0-9e74-bae5163b62ea

  Error: Connection activation failed.

$ echo $?

  4

# later...

$ sudo nmcli device 

  DEVICE           TYPE      STATE                                  CONNECTION         
  enxa44cc89c79ed  ethernet  connecting (getting IP configuration)  Wired connection 1 
  lo               loopback  unmanaged                              --                 

$ sudo tcpdump -i enxa44cc89c79ed "icmp6[0] == 136"                     # « 136 » is « neighbor-advertisement »

  tcpdump: IPv6 upper-layer protocol is not supported by proto[x]

$ sudo tcpdump -i enxa44cc89c79ed "icmp6 && ip6[40] == 136"             # « 136 » is « neighbor-advertisement »

  listening on enxa44cc89c79ed, link-type EN10MB (Ethernet), capture size 262144 bytes

#------------------------------------------------#

« ifconfig »:

# bad...

$ ifconfig -a

  enxa44cc89c79ed Link encap:Ethernet  HWaddr a4:4c:c8:9c:79:ed  
            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
            TX packets:426 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:1000 
            RX bytes:0 (0.0 B)  TX bytes:83224 (83.2 KB)

  lo        Link encap:Local Loopback  
            inet addr:127.0.0.1  Mask:255.0.0.0
            inet6 addr: ::1/128 Scope:Host
            UP LOOPBACK RUNNING  MTU:65536  Metric:1
            RX packets:9500 errors:0 dropped:0 overruns:0 frame:0
            TX packets:9500 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:1 
            RX bytes:812273 (812.2 KB)  TX bytes:812273 (812.2 KB)


# good...

$ ifconfig -a

  enxa44cc89c79ed Link encap:Ethernet  HWaddr a4:4c:c8:9c:79:ed  
            inet addr:10.0.0.162  Bcast:10.0.0.255  Mask:255.255.255.0
            inet6 addr: fe80::8670:b51d:2ee9:3b5/64 Scope:Link
            inet6 addr: 2601:645:8104:a530::8914/128 Scope:Global
            inet6 addr: 2601:645:8104:a530:e4c1:ed5f:6376:e782/64 Scope:Global
            inet6 addr: 2601:645:8104:a530:6af8:da09:6d3:e7ea/64 Scope:Global
            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
            RX packets:20200 errors:0 dropped:0 overruns:0 frame:0
            TX packets:8051 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:1000 
            RX bytes:18014717 (18.0 MB)  TX bytes:1788036 (1.7 MB)

  lo        Link encap:Local Loopback  
            inet addr:127.0.0.1  Mask:255.0.0.0
            inet6 addr: ::1/128 Scope:Host
            UP LOOPBACK RUNNING  MTU:65536  Metric:1
            RX packets:8469 errors:0 dropped:0 overruns:0 frame:0
            TX packets:8469 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:1 
            RX bytes:705704 (705.7 KB)  TX bytes:705704 (705.7 KB)

#------------------------------------------------#

« ip »:

# bad...

$ ip link show

  1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1
      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
  
  3: enxa44cc89c79ed: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
      link/ether a4:4c:c8:9c:79:ed brd ff:ff:ff:ff:ff:ff

$ ip -6 neigh show dev enxa44cc89c79ed

  fe80::1256:11ff:fe88:8970 lladdr 10:56:11:88:89:70 router REACHABLE

# good...

$ ip addr

  1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
      inet 127.0.0.1/8 scope host lo
         valid_lft forever preferred_lft forever
      inet6 ::1/128 scope host 
         valid_lft forever preferred_lft forever

  3: enxa44cc89c79ed: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
      link/ether a4:4c:c8:9c:79:ed brd ff:ff:ff:ff:ff:ff
      inet 10.0.0.162/24 brd 10.0.0.255 scope global dynamic enxa44cc89c79ed
         valid_lft 603906sec preferred_lft 603906sec
      inet6 2601:645:8104:a530::8914/128 scope global dynamic 
         valid_lft 603910sec preferred_lft 603910sec
      inet6 2601:645:8104:a530:e4c1:ed5f:6376:e782/64 scope global temporary dynamic 
         valid_lft 598sec preferred_lft 298sec
      inet6 2601:645:8104:a530:6af8:da09:6d3:e7ea/64 scope global mngtmpaddr noprefixroute dynamic 
         valid_lft 598sec preferred_lft 298sec
      inet6 fe80::8670:b51d:2ee9:3b5/64 scope link 
         valid_lft forever preferred_lft forever

#------------------------------------------------#

« dhclient »:

$ sudo dhclient eth0

  Cannot find device "eth0"

$ sudo dhclient enxa44cc89c79ed 

  RTNETLINK answers: File exists

^ fixed!

#------------------------------------------------#

« apt »:

$ sudo apt install network-manager --reinstall 

  E: Failed to fetch http://security.ubuntu.com/ubuntu/pool/main/n/network-manager/network-manager_1.2.6-0ubuntu0.16.04.3_amd64.deb
     Temporary failure resolving 'archive.ubuntu.com'

# TODO download « http://security.ubuntu.com/ubuntu/pool/main/n/network-manager/network-manager_1.2.6-0ubuntu0.16.04.3_amd64.deb » manually from an online machine (to install offline on this machine).

#------------------------------------------------#

« ip6tables »:

$ sudo ip6tables -L

Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination    

#------------------------------------------------#

« /etc/systemd/ »:

$ ls /etc/systemd/network/

  ∅

#------------------------------------------------#

« /etc/network/ »:

$ cat /etc/network/interfaces

  # interfaces(5) file used by ifup(8) and ifdown(8)
  auto lo
  iface lo inet loopback

M-x find-file 
    /sudo::/etc/network/interfaces

#------------------------------------------------#
 */