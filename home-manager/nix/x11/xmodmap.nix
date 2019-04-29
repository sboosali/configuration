
##################################################
let
#------------------------------------------------#

readXmodmaps = paths:

  builtins.concatStringsSep "\n"
    (builtins.map builtins.readFile paths);

#------------------------------------------------#
in
##################################################
let
#------------------------------------------------#

xmodmaps = [

  ../../../xmodmap/swap_number-row.xmodmap
  ../../../xmodmap/swap_semicolon-with-colon.xmodmap
  ../../../xmodmap/swap_apostrophe-with-quotation.xmodmap

];

#------------------------------------------------#
in
##################################################

readXmodmaps xmodmaps