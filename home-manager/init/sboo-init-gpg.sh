#!/bin/bash
set -e

##################################################

command -v gpg

gpg --version                   #TODO check ≥2.1.17

##################################################

GPG_USER_ID='samboosalis@gmail.com'

##################################################

gpg --full-generate-key

##################################################

gpg --gen-revoke --armor --output=RevocationCertificate.asc ${GPG_USER_ID}

##################################################

gpg init ${GPG_USER_ID}

##################################################

##################################################
# Notes ##########################################
##################################################

# « https://wiki.archlinux.org/index.php/GnuPG#Configuration_files »

##################################################

# NOTE Whenever a « user-id » is required in a command,
# it can be specified with:
#
# * your key ID,
# * fingerprint,
# * a part of your name,
# * your email address,
# * etc.
#
# GnuPG is flexible on this.

##################################################

# e.g.:
#
#     $ gpg --full-generate-key
#    
#     gpg (GnuPG) 2.2.11; Copyright (C) 2018 Free Software Foundation, Inc.
#     This is free software: you are free to change and redistribute it.
#     There is NO WARRANTY, to the extent permitted by law.
#    
#     Please select what kind of key you want:
#        (1) RSA and RSA (default)
#        (2) DSA and Elgamal
#        (3) DSA (sign only)
#        (4) RSA (sign only)
#     • Your selection? 1
#    
#     RSA keys may be between 1024 and 4096 bits long.
#     • What keysize do you want? (2048) 4096
#     Requested keysize is 4096 bits
#    
#     Please specify how long the key should be valid.
#              0 = key does not expire
#           <n>  = key expires in n days
#           <n>w = key expires in n weeks
#           <n>m = key expires in n months
#           <n>y = key expires in n years
#     • Key is valid for? (0) 12y
#     Key expires at Wed Dec 11 14:04:36 2030 PST
#     
#     GnuPG needs to construct a user ID to identify your key.
#     • Real name: Sam Boosalis
#     • Email address: samboosalis@gmail.com
#     • Comment: sboosali
#     You selected this USER-ID:
#         "Sam Boosalis (sboosali) <samboosalis@gmail.com>"
#     
#     # an input-dialog pops up, in which you enter your passphrase (twice).
#     
#     We need to generate a lot of random bytes. It is a good idea to perform
#     some other action (type on the keyboard, move the mouse, utilize the
#     disks) during the prime generation; this gives the random number
#     generator a better chance to gain enough entropy.
#     gpg: /home/sboo/.gnupg/trustdb.gpg: trustdb created
#     gpg: key 96581B5997622007 marked as ultimately trusted
#     gpg: directory '/home/sboo/.gnupg/openpgp-revocs.d' created
#     gpg: revocation certificate stored as '/home/sboo/.gnupg/openpgp-revocs.d/FAE77E1A10376FD9381DDB2596581B5997622007.rev'
#    
#     public and secret key created and signed.
#     pub   rsa4096 2018-12-14 [SC] [expires: 2030-12-11]
#           FAE77E1A10376FD9381DDB2596581B5997622007
#     uid                      Sam Boosalis (sboosali) <samboosalis@gmail.com>
#     sub   rsa4096 2018-12-14 [E] [expires: 2030-12-11]
#    

##################################################

# e.g.
#
#    $ gpg --gen-revoke --armor --output=RevocationCertificate.asc <user-id>

##################################################

# e.g.
#
#     $ gpg --list-keys
#     
#     /home/sboo/.gnupg/pubring.kbx
#     -----------------------------
#     pub   rsa4096 2018-12-14 [SC] [expires: 2030-12-11]
#           FAE77E1A10376FD9381DDB2596581B5997622007
#     uid           [ultimate] Sam Boosalis (sboosali) <samboosalis@gmail.com>
#     sub   rsa4096 2018-12-14 [E] [expires: 2030-12-11]

##################################################

# e.g.
#
#     $ gpg --output 'public_samboosalis.key' --armor --export 'samboosalis'
#     
#     
#     

##################################################
##################################################

# > This certificate can be used to revoke your key if it is ever lost or compromised. Do not neglect this step! Print it out, save it on a disk, and store it safely. It will be short enough that you can type it back in by hand without much effort if you just print it out.
# > 
# >  If you lose your secret key or it is compromised, you will want to revoke your key by uploading the revocation certificate to a public keyserver (assuming you uploaded your public key to a public keyserver in the first place).
# > 
# > Protect your revocation key like you protect your secret keys. 

##################################################

# To list keys in your public key ring:
# 
#     $ gpg --list-keys

# To list keys in your secret key ring:
# 
#     $ gpg --list-secret-keys

##################################################

# > In order for others to send encrypted messages to you, they need your public key.
# > 
# > To generate an ASCII version of a user's public key to file public.key (e.g. to distribute it by e-mail): function 
# >
#     $ gpg --output public_USERID.key --armor --export USERID
# > 

##################################################

# > To ease the migration to the no-secring method, gpg detects the presence of a secring.gpg and converts the keys on-the-fly to the the key store of gpg-agent (this is the private-keys-v1.d directory below the GnuPG home directory (~/.gnupg)). 

# Print out your private key, and "keep it secret, keep it safe".
#
#     $ gpg -a --export-secret-keys USERID > private_USERID.key
# 
#     $ lpr -o "sides=two-sided-long-edge" "private_USERID.key"
# 

##################################################

# « gpg-agent »:
# 
# > gpg-agent is mostly used as daemon to request and cache the password for the keychain. This is useful if GnuPG is used from an external program like a mail client. gnupg comes with systemd user sockets which are enabled by default. These sockets are gpg-agent.socket, gpg-agent-extra.socket, gpg-agent-browser.socket, gpg-agent-ssh.socket, and dirmngr.socket.
# > 

##################################################

# > 

##################################################

# > 

##################################################