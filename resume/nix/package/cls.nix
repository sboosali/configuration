##################################################
{ pkgs
}:

##################################################
{ resume
}:

assert (builtins.isString resume);

##################################################
pkgs.writeTextFile 

  { name = "resume.cls";
    text = resume;
  }

##################################################