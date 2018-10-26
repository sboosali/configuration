##################################################
{ pkgs
}:

##################################################
let

self  = pkgs;
super = pkgs;

in
##################################################
let

sbooLibraries = super.buildEnv
 {
   name                  = "sboo-libraries";

   paths                 = systemLibraries;
   pathsToLink           = [ "/" "/lib" "/include" ];
   extraOutputsToInstall = [ "out" "dev" "doc" "devdoc" "man" "info" ];

   #ignoreCollisions      = true;
 };

##################################################

systemLibraries = with pkgs; [

 zlib
 zlib.static
 
 flac
 
];

in
##################################################

sbooLibraries

##################################################
# Notes ##########################################
##################################################

# NOTE « out » is necessary in
# « extraOutputsToInstall = [ "out" "dev" "doc" "devdoc" "man" "info" ]; ».
#
# otherwise, for example, « flac » doesn't work. because its default « output »,
# i.e. the first item of the « outputs » list, isn't « out »:
#
# nix-repl> pkgs.flac.outputs
# [ "bin" "dev" "out" "man" "doc" ]
#

##################################################

# nix-repl> map (d: d.outPath) pkgs.flac.all
# [ "/nix/store/m4rqy85z4ph1x3da6c634l5g8bsvk5z6-flac-1.3.2-bin" "/nix/store/vaffp9vcpxrn4nwrwx3i9kj9384yw713-flac-1.3.2-dev" "/nix/store/dcsbqy075g5q9yaxij2q7x3izm7wzg9z-flac-1.3.2" "/nix/store/9qfmfiqfxq2354323x6gcpqp9375a0h1-flac-1.3.2-man" "/nix/store/84vsc3pp8mcyw07l6y5m1b30zwdhbm8z-flac-1.3.2-doc" ]

/*

"/nix/store/dcsbqy075g5q9yaxij2q7x3izm7wzg9z-flac-1.3.2"
"/nix/store/m4rqy85z4ph1x3da6c634l5g8bsvk5z6-flac-1.3.2-bin"
"/nix/store/vaffp9vcpxrn4nwrwx3i9kj9384yw713-flac-1.3.2-dev"
"/nix/store/9qfmfiqfxq2354323x6gcpqp9375a0h1-flac-1.3.2-man"
"/nix/store/84vsc3pp8mcyw07l6y5m1b30zwdhbm8z-flac-1.3.2-doc"

*/

##################################################
