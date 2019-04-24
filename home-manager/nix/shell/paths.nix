##################################################
{}:

##################################################

[

 ~/configuration/bin            # my personal/downloaded programs
 ~/configuration/scripts        # my personal/downloaded programs
 ~/bin                          # my personal/downloaded programs

 ~/configuration/bin/x86_64-linux/pandoc-2.7.2/bin # TODO

 ~/.cabal/bin                   # installed by « cabal »
 ~/.local/bin                   # installed by « stack »

 ~/.nix-profile/bin             # installed by « nix »

 /bin                           # 
 /sbin
 /usr/bin                       # 
 /usr/sbin
 /usr/local/bin                 # 
 /usr/local/sbin
#/snap/bin                       # installed by « apt »?

]

##################################################
# Notes ##########################################
##################################################
/*

^ NOTE:

  1. Nix evaluates path-literals at parse-time,
     but they're not checked for existence (and thus won't fail if a path-literal doesn't exists).

     Also, relative paths are always relative to the current file,
     so most paths above should be written as absolute.

  2. 

*/

#TODO PATH has these below before the above: /home/sboo/.nix-profile/bin:/home/sboo/.local/bin:/home/sboo/.nix-profile/bin:...

##################################################