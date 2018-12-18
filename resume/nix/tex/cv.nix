##################################################
{ tex ? import ./tex.nix {}
}:

##################################################
let

cv = {

  inherit mkEducation mkSchool mkCareer mkJob;

  inherit mkDate;

};

##################################################

mkEducation = { indentation ? 0 }:
              schools:

  let
  body = builtins.concatMap mkSchool schools;
  in

  tex.environment { name = "cventries";
                    inherit body;

                    multiline = true; string = true;
                    inherit indentation;
                  };

##################################################

mkSchool =

  { school
  , location
  , degree
  , from
  , to ? null
  , items
  }:

  let
  arguments = [ school location degree dates items' ];

  items'    = mkItems items;
  dates     = mkDate { inherit from to; };
  in

  tex.command { name = "cventry";
                options = [];
                inherit arguments;

                multiline = true; string = false;
              };

##################################################

mkCareer = { indentation ? 0 }:
           jobs:

  let
  body = builtins.concatMap mkJob jobs;
  in

  tex.environment { name = "cventries";
                    inherit body;

                    multiline = true; string = true;
                    inherit indentation;
                  };

##################################################

mkJob =

  { employer
  , location
  , position
  , from
  , to ? null
  , items ? []
  }:

  let
  arguments = [ employer location position dates items' ];

  items'    = mkItems items;
  dates     = mkDate { inherit from to; };
  in

  tex.command { name = "cventry";
                options = [];
                inherit arguments;

                multiline = true; string = false;
              };

##################################################

mkDate = { from, to ? null }:

  let
  bothDates = ''${startDate} — ${endDate}'';

  startDate = builtins.toString from;

  endDate   = if   to != null
              then builtins.toString to
              else "current";
  in

  bothDates;

##################################################

mkItems = items:

  assert (
    (builtins.isList items)
  );

  let
  body = builtins.concatMap mkItem items;
  in

  tex.environment { name = "cvitems";
                    body = body;

                    multiline = true; string = false; 
                  };

##################################################

mkItem = sentences:

  assert (
    (builtins.isList sentences || builtins.isString sentences)
  );

  let
  paragraph =
    if   builtins.isList sentences
    then builtins.concatStringsSep '' \par '' sentences
    else sentences;
  in

  tex.command { name = "item";
                arguments = [ paragraph ];

                multiline = false;
              };

##################################################
in
##################################################

cv

##################################################