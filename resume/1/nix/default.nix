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

package = import ./package { inherit pkgs; }
  { inherit resume data basename;
  };

in
##################################################
{

  resume.pdf  = package.pdf;
  resume.tex  = package.tex;
  resume.cls  = package.cls;
  resume.json = package.json;

}
##################################################