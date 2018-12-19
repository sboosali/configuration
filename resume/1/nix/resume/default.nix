##################################################
{
}:

##################################################
let

inherit (import ../tex {})
        tex
        cv;

##################################################

data = import ./samboosalis.nix {};

basename = "sam_boosalis";

##################################################

resume-tex = import ./resume.tex.nix { inherit tex cv; }
  data;

##################################################

resume-cls = import ./resume.cls.nix { }
  { fonts = ../../src/fonts;
  };

in
##################################################
{

  resume.tex = resume-tex;
  resume.cls = resume-cls;

  inherit data basename;

}
################################################## $resumePath