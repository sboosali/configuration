##################################################
{ pkgs
}:

##################################################
{ data
}:

assert (builtins.isAttrs data);

##################################################
pkgs.writeTextFile 

  { name = "resume.json";
    text = builtins.toJSON data;
  }

##################################################