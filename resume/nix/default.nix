##################################################
{ pkgs ? (import <nixpkgs> {}).pkgs
}:

##################################################
let

inherit (import ./resume { })
        resume
        data
        basename
        ;

##################################################

package = import ./resume/package.nix { inherit (pkgs) stdenv texlive; }
  { inherit resume;
    inherit basename;
  };

in
##################################################
{

  resume.json = builtins.toJSON data;
  resume.tex  = resume;
  resume.pdf  = package;

}
##################################################