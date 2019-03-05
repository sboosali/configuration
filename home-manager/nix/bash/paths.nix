[

 ~/configuration/bin            # my personal/downloaded programs
 ~/configuration/scripts        # my personal/downloaded programs
 ~/bin                          # my personal/downloaded programs

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

# ^ NOTE Nix evaluates path-literals at parse-time,
# but they're not checked for existence (and thus won't fail if a path-literal doesn't exists).
#
# Also, relative paths are always relative to the current file,
# so most paths above should be written as absolute.
#

#TODO PATH has these below before the above: /home/sboo/.nix-profile/bin:/home/sboo/.local/bin:/home/sboo/.nix-profile/bin:...
