##################################################
{ lib
}:

##################################################
let



in
##################################################
{ Name
, Exec    ? Name
, TryExec ? Exec
, Path    ? null

, Version  ? "1.1"
, Type     ? "Application"
, Encoding ? "UTF-8"

, GenericName ? null
, NoDisplay   ? null
, Comment ? null
, Icon ? null
, Hidden ? null


}

##################################################
/* Notes *****************************************

Keys:

- `Version` — Version of the Desktop Entry Specification that the desktop entry conforms with. Entries that confirm with this version of the specification should use 1.1.
- `Name` — REQUIRED — Specific name of the application, for example "Mozilla".
- `GenericName` — Generic name of the application, for example "Web Browser".	
- `NoDisplay` — means "this application exists, but don't display it in the menus".
- `Comment` — Tooltip for the entry, for example "View sites on the Internet". The value should not be redundant with the values of Name and GenericName.
- `Icon` — Icon to display in file manager, menus, etc. If the name is an absolute path, the given file will be used. 
- `Hidden` — Hidden should have been called Deleted. It means the user deleted (at his level) something that was present (at an upper level, e.g. in the system dirs). It's strictly equivalent to the .desktop file not existing at all, as far as that user is concerned. This can also be used to "uninstall" existing files (e.g. due to a renaming) - by letting make install install a file with Hidden=true in it.


**************************************************

See:

- « https://wiki.archlinux.org/index.php/desktop_entries »
- « https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html#recognized-keys »

*************************************************/
