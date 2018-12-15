##################################################
{ pkgs
}:

##################################################
let

syncDir = ~/configuration/dotfiles;

mkSyncPath = path: 

  ''${toString syncDir}/${toString path}'';

  #^ e.g. « home.file."${mkSyncPath "firefox"}".source = ... »

mkSyncFile = source:

  { source    = mkSyncPath source;
    target    = "."; 
    recursive = true; 
  };

  #^ e.g. « ~/configuration/dotfiles/firefox/.firefox » gets linked into « ~/.firefox ».

mkSyncAttr = source:

  { name  = source;
    value = mkSyncFile source;
  };

mkSyncHome = sources:

  builtins.listToAttrs
    (builtins.map mkSyncAttr
      sources);

in
##################################################

mkSyncHome [

 "/firefox"

]

##################################################