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

   paths                 = libraries;
   pathsToLink           = [ "/" "/src" "/lib" "/include" ];
   extraOutputsToInstall = [ "out" "dev" "doc" "devdoc" "man" "info" ];

   ignoreCollisions      = true;
 };

##################################################

libraries =
  systemLibraries ++
  x11Libraries    ++
  ghcLibraries    ++
  fltkhsLibraries ;

##################################################

systemLibraries = with pkgs; [

 flac
 openssl
 zlib
 zlib.static

];

##################################################

x11Libraries = with pkgs.xlibs; [

];

##################################################

fltkhsLibraries = [ fltkhsFLTK ] ++ fltkLibraries;

##################################################

fltkhsFLTK = super.buildEnv
 {
   name                  = "sboo-fltk";

   paths                 = with pkgs; [ fltk ];
   pathsToLink           = [ "/" "/src" "/lib" "/include" "/include/FL" "/FL" "GL/" ];
   extraOutputsToInstall = [ "out" "dev" ];

 };

##################################################

fltkLibraries = with pkgs; [

 xlibsWrapper

 xlibs.libX11
 xlibs.libXext
 xlibs.libXft
 xlibs.libXinerama

 xlibs.libX11.dev
 xlibs.libXext.dev
 xlibs.libXft.dev
 xlibs.libXinerama.dev

 libjpeg
 libpng
 fontconfig

 libjpeg.dev
 libpng.dev
 fontconfig.dev

#m
#pthread
 zlib
 bzip2     # « bz2 »

 freeglut
 libGLU_combined

 pkgconfig
 
];

# ^ See « https://github.com/NixOS/nixpkgs/blob/release-18.09/pkgs/development/libraries/fltk/default.nix ».

##################################################

ghcLibraries = with pkgs; [

 ncurses
 ncurses.dev

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
