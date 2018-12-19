##################################################
{ pkgs ? (import <nixpkgs> {}).pkgs
}:

##################################################
{ resume
, data
, basename
}:

##################################################
{

  pdf = import ./pdf.nix { inherit (pkgs) stdenv texlive; }
    { inherit resume;
      inherit basename;
    };

  tex = import ./tex.nix { inherit pkgs; }
    { resume = resume.tex;
    };

  cls = import ./cls.nix { inherit pkgs; }
    { resume = resume.cls;
    };

  json = import ./json.nix { inherit pkgs; }
    { inherit data;
    };

}
##################################################