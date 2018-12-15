##################################################
{ pkgs

, sboo

, haskellPackages   ? (pkgs.haskellPackages)
, haskellCompilers  ? (pkgs.haskell.compiler)

}:

##################################################
let

self  = pkgs;
super = pkgs;

in
##################################################
let

sbooPrograms = super.buildEnv
 {
   name                  = "sboo-programs";

   paths                 = programs;
   pathsToLink           = [ "/" "/bin" ];
   extraOutputsToInstall = [ "out" "bin" "man" "info" ];

   ignoreCollisions      = true;
 };

##################################################

programs =
     freePrograms
  ++ unfreePrograms
     ;

##################################################

freePrograms = builtins.concatLists [

  systemPrograms
  haskellPrograms
  xorgPrograms
  x11Programs

];

# systemPrograms ++ haskellPrograms ++ haskellCompilerPrograms ++ xorgPrograms;

##################################################

unfreePrograms = with self; [

 dropbox

 google-chrome

 #TODO dwarf-fortress

 idea                           # "IntelliJ IDEA".

 #TODO enpass                         # Password Manager (cross-platform). See « https://www.enpass.io/ ».

];

##################################################

systemPrograms = import ./programs/system-programs.nix { inherit pkgs; };

# ^ NOTE we must omit the `programs._` programs:
#
# * emacs26
# * git
# * firefox
# * ...
#
# from the `home.packages = _` programs.
#

##################################################

x11Programs = with pkgs.xlibs; [

 xbacklight

];

########################################

xorgPrograms = with self.xorg; [

 xinput
 xmessage
 xmodmap
 xprop

];

##################################################

haskellPrograms = with haskellPackages; [

 alex
 happy
 hscolour

 ghcid
 hpack
 git-annex

];

in
##################################################
sbooPrograms
##################################################