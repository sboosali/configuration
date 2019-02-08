##################################################
{ lib
}:

/* a Desktop Action is a subset of a Desktop Entry.
 *
 */

##################################################
let

desktop-types = import ./desktop-types.nix { inherit lib; };

in
##################################################

with desktop-types;

##################################################
let

options = {

  Name = localestring "Name"
         "Label that will be shown to the user. Since actions are always shown in the context of a specific application (that is, as a submenu of a launcher), this only needs to be unambiguous within one application and should not include the application name."
         ""

  Icon = localestring "Icon"
         "Icon to be shown togheter with the action. If the name is an absolute path, the given file will be used. If the name is not an absolute path, the algorithm described in the Icon Theme Specification will be used to locate the icon. Implementations may choose to ignore it."
         ""

  Exec = string "Exec"
         "Program to execute for this action, possibly with arguments. See the <code>Exec</code> key for details on how this key works. The <code>Exec</code> key is required if DBusActivatable is not set to <code>true</code> in the main desktop entry group. Even if <code>DBusActivatable</code> is <code>true</<code>code</code>>, Exec should be specified for compatibility with implementations that do not understand <code>DBusActivatable</code>."
         ""

};

in
##################################################
{

  inherit options;

}
##################################################
