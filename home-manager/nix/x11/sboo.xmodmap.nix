##################################################
let
#------------------------------------------------#

inherit (import ./lib/keycodes.nix) keycode;

#------------------------------------------------#
in
##################################################

''
! ============================================== !

! 2015-06-15
! http://xahlee.info/linux/linux_xmodmap_tutorial.html

! ---------------------------------------------- !

! change unshifted layout,
! but the preserve the shifted symbols.

! ---------------------------------------------- !
! Keybindings ---------------------------------- !
! ---------------------------------------------- !

! parentheses:
!
! ① free from Shift.
! ② bring them closer.

keycode 34 = parenleft braceleft parenleft braceleft
keycode 35 = parenright braceright parenright braceright

! ---------------------------------------------- !

! (square) brackets:
!
! replace (the previous location of) parentheses.

${keycode 18} = 9 bracketleft 9 bracketleft
keycode 19 = 0 bracketright 0 bracketright

! ---------------------------------------------- !
! Notes -----------------------------------------!
! ---------------------------------------------- !

! $ xmodmap -pke
!
!   keycode  18 = 9 parenleft 9 parenleft
!   keycode  19 = 0 parenright 0 parenright
!   keycode  ...
!   keycode  34 = bracketleft braceleft bracketleft braceleft
!   keycode  35 = bracketright braceright bracketright braceright
!

! what the default is:
!
!   keycode  18 = 9 ( 9 (
!   keycode  19 = 0 ) 0 )
!   keycode  34 = [ } [ }
!   keycode  35 = ] } ] }
!
! what we want:
!
!   keycode  18 = 9 [ 9 [
!   keycode  19 = 0 ] 0 ]
!   keycode  34 = ( } ( }
!   keycode  35 = ) } ) }
!
! i.e.:
!
! preserve « 9 0 » and « { } ».

! ============================================== !
''