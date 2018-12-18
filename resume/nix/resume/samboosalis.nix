##################################################
{}:

##################################################
let
##################################################

class = "resume";

fontsize = 11;

##################################################

contact = {

  name.first = "Sam";
  name.last  = "Boosalis";

  address  = "San Francisco";
  mobile   = "+1 (617) 922-0791"; # TODO call: link?
  email    = "samboosalis@gmail.com"; # TODO mailto: link?
  homepage = "sboosali.github.io";

  # TODO homepage = https://sboosali.github.io;

};

##################################################

education = [

  {
    school   = "Brown University";
    location = "Providence, RI";
    degree   = "Computer Science B.A.";
    from     = 2009;
    to       = 2013;
    items    = [
      [
        "Implemented a compiler for an ML langauge with recursive bindings and Hindley-Milner type inference."
        "Parsed, typechecked, name-checked, optimized, and assembled (into MIPS)."
      ]
    ];
  }

];

##################################################

career = [

  {
    employer = "Turn Inc.";
    location = "Redwood City, CA";
    position = "Research Software Engineer";
    from     = "Feb 2014";
    to       = "Jan 2015";
    items    = [
      "Implemented Multi-Touch Attribution: "
    ];
  }

  # {
  #   employer = "";
  #   location = "";
  #   position = "";
  #   from     = "";
  #   to       = "";
  #   items    = [
  #   ];
  # }

  # {
  #   employer = "";
  #   location = "";
  #   position = "";
  #   from     = "";
  #   to       = "";
  #   items    = [
  #   ];
  # }

];

##################################################
in
##################################################
{

  inherit class fontsize;
  inherit contact education career;

}
##################################################