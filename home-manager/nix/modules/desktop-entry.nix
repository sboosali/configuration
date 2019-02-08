##################################################
{ lib

, desktop-action
}:

/* a Desktop Entry file is an INI file with particular keys
 * (see <code>options</code> below).
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

  Version = string "Version"

    "Version of the Desktop Entry Specification that the desktop entry conforms with. Entries that confirm with this version of the specification should use <code>1.1</code>."
    "1.1";

  Name = string-required "Name"

    "Specific name of the application."
    "Mozilla";

  GenericName = string-required "GenericName"

    "Generic name of the application."
    "Web Browser";

  NoDisplay = bool "NoDisplay"

    "<code>NoDisplay=truee</code> means \"This application exists, but don't display it in the menus\"."
    "";

  Comment = string "Comment"

    "Tooltip for the entry. The value should not be redundant with the values of <code>Name</code> and <code>GenericName</code>."
    "Browse the Web, with Privacy.";

  Icon = path "Icon"

    "Icon to display in file manager, menus, etc. If the name is an absolute path, the given file will be used."
    ''~/.local/share/icons/hicolor/128x128/apps/firefox/PyroPitbull.png'';

  Hidden = bool "Hidden"

    "<code>Hidden</code> should have been called <code>Deleted</code>. It means the user deleted (at his level) something that was present (at an upper level, e.g. in the system dirs). It's strictly equivalent to the .desktop file not existing at all, as far as that user is concerned. This can also be used to \"uninstall\" existing files (e.g. due to a renaming) - by letting make install install a file with Hidden=true in it."
    false;

  OnlyShowIn = listof-string "OnlyShowIn"

    "A whitelist. A list of strings identifying the desktop environments that should display a given desktop entry. By default, a desktop file should be shown, unless an OnlyShowIn key is present, in which case, the default is for the file not to be shown. If <code>$XDG_CURRENT_DESKTOP</code> is set then it contains a colon-separated list of strings. In order, each string is considered. If a matching entry is found in <code>OnlyShowIn</code> then the desktop file is shown. If none of the strings match then the default action is taken (as above). <code>$XDG_CURRENT_DESKTOP</code> should have been set by the login manager, according to the value of the <code>DesktopNames</code> found in the session file. The entry in the session file has multiple values separated in the usual way: with a semicolon. The same desktop name may not appear in both <code>OnlyShowIn</code> and <code>NotShowIn</code> of a group."
    [ "" ];

  NotShowIn = listof-string "NotShowIn"

    "A blacklist. A list of strings identifying the desktop environments that should NOT display a given desktop entry. If an entry is found in NotShowIn then the desktop file is not shown. (See also <code>OnlyShowIn</code>)."
    [ "" ];

  TryExec = string "TryExec"

    "Path to an executable file on disk used to determine if the program is actually installed. If the path is not an absolute path, the file is looked up in the <code>$PATH</code> environment variable. If the file is not present or if it is not executable, the entry may be ignored (not be used in menus, for example)."
    "firefox";

  Exec = string "Exec"

    "Program to execute, possibly with arguments. See the <code>Exec</code> key for details on how this key works. The <code>Exec</code> key is required if <code>DBusActivatable</code> is not set to <code>true</code>. Even if <code>DBusActivatable</code> is <code>true</code>, <code>Exec</code> should be specified for compatibility with implementations that do not understand <code>DBusActivatable</code>. NOTE a few \"Field Codes\" are accepted: <code>%u</code> (i.e. lowercase letter-U) interpolates a single URL, local files may either be passed as <code>file://</code> URLs or directly as FilePaths; <code>%U</code> (i.e. uppercase letter-U) interpolates a list of URLs, each URL is passed as a separate argument to the executable program."
    "firefox %U";

  DBusActivatable = bool "DBusActivatable"

    "A boolean value specifying if D-Bus activation is supported for this application. If this key is missing, the default value is false. If the value is true then implementations should ignore the Exec key and send a D-Bus message to launch the application. See D-Bus Activation for more information on how this works. Applications should still include <code>Exec=</code> lines in their desktop files for compatibility with implementations that do not understand the <code>DBusActivatable</code> key."
    null;

  Path = path "Path"

    "If entry is of type <code>Application</code>, the working directory to run the program in."
    ''~/.emacs.d'';

  Terminal = bool "Terminal"

    "Whether the program runs in a terminal window."
    false;

  Actions = (listof desktop-action) "Actions"

    "Identifiers for application actions. This can be used to tell the application to make a specific action, different from the default behavior."
    [ { Name = "Open DuckDuckGo"; Exec = "firefox https://duckduckgo.com/"; Icon = null; 
      }
    ];

  MimeType = listof-string "MimeType"

    "The MIME type(s) supported by this application."
    [ "text/html" "text/xml" ];

  Categories = listof-string "Categories"

    "Categories in which the entry should be shown in a menu (for possible values see the Desktop Menu Specification)."
    [ "Application" "Network" "WebBrowser" ];

  Implements = listof-string "Implements"

    "A list of interfaces that this application implements. By default, a desktop file implements no interfaces."
    [];

  Keywords = listof-localestring "Keywords"

    "A list of strings which may be used in addition to other metadata to describe this entry. This can be useful e.g. to facilitate searching through entries. The values are not meant for display, and should not be redundant with the values of <code>Name</code> or <code>GenericName</code>."
    [ "Browser" ];

  StartupNotify = bool "StartupNotify"

    "If true, it is KNOWN that the application will send a \"remove\" message when started with the <code>DESKTOP_STARTUP_ID</code> environment variable set. If <code>false</code>, it is KNOWN that the application does not work with startup notification at all (does not shown any window, breaks even when using <code>StartupWMClass</code>, etc.). If absent, a reasonable handling is up to implementations (assuming <code>false</code>, using <code>StartupWMClass</code>, etc.). (See the Startup Notification Protocol Specification for more details)."
    true;

  StartupWMClass = string "StartupWMClass"

    "If specified, it is known that the application will map at least one window with the given string as its WM class or WM name hint (see the Startup Notification Protocol Specification for more details)."
    "Navigator";

};

in
##################################################
{

  inherit options;

}
##################################################
