##################################################
{}:

##################################################
{ Name

, Exec    ? Name
, TryExec ? null
, Path    ? null

, Version  ? "1.1"
, Type     ? "Application"
, Encoding ? "UTF-8"

, GenericName     ? null
, Comment         ? null
, Icon            ? null
, StartupWMClass  ? null
, Terminal        ? null

, MimeType        ? null
, Keywords        ? null
, Categories      ? null

, Hidden          ? null
, NoDisplay       ? null
, OnlyShowIn      ? null
, NotShowIn       ? null
, StartupNotify   ? null

, DBusActivatable ? null

, Actions         ? []
, Implements      ? []

}:

##################################################
let

/* :: Maybe Bool -> Maybe String
 *
 * preserves <code>null</code>.
 *
 */

asBool = x:

  if   builtins.isBool x
  then ( if x then "true" else "false" )
  else null

/* :: Maybe Path -> Maybe String
 *
 * preserves <code>null</code>.
 *
 */

asPath = x:

  if   "path" == builtins.typeOf x
  then ''${x}''

  else
  if   "string" == builtins.typeOf x
  then x

  else null

/* :: Maybe String -> Maybe String
 *
 * preserves <code>null</code>.
 *
 */

asString = x:

  if   null == x
  then null
  else builtins.toString x

/* :: Maybe [String] -> Maybe String
 *
 * intercalate semicolons — i.e. a string which represents a Semicolon-Separated list.
 *
 * preserves <code>null</code>.
 *
 */

asList = xs:

  let
  ys = builtins.concatStringsSep ";" xs

  zs = if ys == "" then null else ys
  in

  if   builtins.isList xs
  then zs
  else null

##################################################

commentIfNull = key: value:

  let
  comment = if value == null then "# " else ""

  binding = ''${key}=${value}''
  in

  comment + binding;

in
##################################################
let

actions         = asList   Actions
categories      = asList   Categories
comment         = asString Comment
dbusactivatable = asBool   DBusActivatable
exec            = asString Exec
genericname     = asString GenericName
hidden          = asBool   Hidden
icon            = asPath   Icon
implements      = asList   Implements
keywords        = asList   Keywords
mimetype        = asList   MimeType
name            = asString Name
nodisplay       = asBool   NoDisplay
notshowin       = asList   NotShowIn
onlyshowin      = asList   OnlyShowIn
path            = asPath   Path
startupnotify   = asBool   StartupNotify
startupwmclass  = asString StartupWMClass
terminal        = asBool   Terminal
tryexec         = asString TryExec

in
##################################################
''
########################################
[Desktop Entry]

Version=${Version}
Type=${Type}
Encoding=${Encoding}

#############################

Name=${name}

#############################

Exec=${exec}
${commentIfNull "TryExec" tryexec}
${commentIfNull "Path"    path}

#############################

${commentIfNull "Categories"      categories}
${commentIfNull "Comment"         comment}
${commentIfNull "DBusActivatable" dbusactivatable}
${commentIfNull "GenericName"     genericname}
${commentIfNull "Hidden"          hidden}
${commentIfNull "Icon"            icon}
${commentIfNull "Keywords"        keywords}
${commentIfNull "MimeType"        mimetype}
${commentIfNull "NoDisplay"       nodisplay}
${commentIfNull "NotShowIn"       notshowin}
${commentIfNull "OnlyShowIn"      onlyshowin}
${commentIfNull "StartupNotify"   startupnotify}
${commentIfNull "StartupWMClass"  startupwmclass}
${commentIfNull "Terminal"        terminal}

#############################

${commentIfNull "Implements" implements}
${commentIfNull "Actions"    actions}

########################################
''
##################################################
/* Notes *****************************************

Keys:

- `Version`                  — Version of the Desktop Entry Specification that the desktop entry conforms with. Entries that confirm with this version of the specification should use 1.1.

- `Name`                     — REQUIRED — Specific name of the application, for example "Mozilla".

- `GenericName`              — Generic name of the application, for example "Web Browser".	

- `NoDisplay`                — means "this application exists, but don't display it in the menus".

- `Comment`                  — Tooltip for the entry, for example "View sites on the Internet". The value should not be redundant with the values of Name and GenericName.

- `Icon`                     — Icon to display in file manager, menus, etc. If the name is an absolute path, the given file will be used. 

- `Hidden`                   — Hidden should have been called Deleted. It means the user deleted (at his level) something that was present (at an upper level, e.g. in the system dirs). It's strictly equivalent to the .desktop file not existing at all, as far as that user is concerned. This can also be used to "uninstall" existing files (e.g. due to a renaming) - by letting make install install a file with Hidden=true in it.

- `OnlyShowIn` & `NotShowIn` —  A list of strings identifying the desktop environments that should display/not display a given desktop entry. By default, a desktop file should be shown, unless an OnlyShowIn key is present, in which case, the default is for the file not to be shown. If $XDG_CURRENT_DESKTOP is set then it contains a colon-separated list of strings. In order, each string is considered. If a matching entry is found in OnlyShowIn then the desktop file is shown. If an entry is found in NotShowIn then the desktop file is not shown. If none of the strings match then the default action is taken (as above). $XDG_CURRENT_DESKTOP should have been set by the login manager, according to the value of the DesktopNames found in the session file. The entry in the session file has multiple values separated in the usual way: with a semicolon. The same desktop name may not appear in both OnlyShowIn and NotShowIn of a group.

- `TryExec`                  — Path to an executable file on disk used to determine if the program is actually installed. If the path is not an absolute path, the file is looked up in the $PATH environment variable. If the file is not present or if it is not executable, the entry may be ignored (not be used in menus, for example).

- `Exec`                     — Program to execute, possibly with arguments. See the Exec key for details on how this key works. The Exec key is required if DBusActivatable is not set to true. Even if DBusActivatable is true, Exec should be specified for compatibility with implementations that do not understand DBusActivatable.

- `DBusActivatable`          — A boolean value specifying if D-Bus activation is supported for this application. If this key is missing, the default value is false. If the value is true then implementations should ignore the Exec key and send a D-Bus message to launch the application. See D-Bus Activation for more information on how this works. Applications should still include Exec= lines in their desktop files for compatibility with implementations that do not understand the DBusActivatable key.

- `Path`                     — If entry is of type Application, the working directory to run the program in.

- `Terminal`                 — Whether the program runs in a terminal window.

- `Actions`                  — Identifiers for application actions. This can be used to tell the application to make a specific action, different from the default behavior. 

- `MimeType`                 — The MIME type(s) supported by this application.

- `Categories`               — Categories in which the entry should be shown in a menu (for possible values see the Desktop Menu Specification).	string(s)	NO	1

- `Implements`               — A list of interfaces that this application implements. By default, a desktop file implements no interfaces.

- `Keywords`                 — A list of strings which may be used in addition to other metadata to describe this entry. This can be useful e.g. to facilitate searching through entries. The values are not meant for display, and should not be redundant with the values of Name or GenericName.	localestring(s)	NO	1

- `StartupNotify`            — If true, it is KNOWN that the application will send a "remove" message when started with the DESKTOP_STARTUP_ID environment variable set. If false, it is KNOWN that the application does not work with startup notification at all (does not shown any window, breaks even when using StartupWMClass, etc.). If absent, a reasonable handling is up to implementations (assuming false, using StartupWMClass, etc.). (See the Startup Notification Protocol Specification for more details).	boolean	NO	1

- `StartupWMClass`           — If specified, it is known that the application will map at least one window with the given string as its WM class or WM name hint (see the Startup Notification Protocol Specification for more details).

- ``                         — 

**************************************************

Example:

    [Desktop Entry]
    
    # The type as listed above
    Type=Application
    
    # The version of the desktop entry specification to which this file complies
    Version=1.0
    
    # The name of the application
    Name=jMemorize
    
    # A comment which can/will be used as a tooltip
    Comment=Flash card based learning tool
    
    # The path to the folder in which the executable is run
    Path=/opt/jmemorise
    
    # The executable of the application, possibly with arguments.
    Exec=jmemorize
    
    # The name of the icon that will be used to display this entry
    Icon=jmemorize
    
    # Describes whether this application needs to be run in a terminal or not
    Terminal=false
    
    # Describes the categories in which this entry should be shown
    Categories=Education;Languages;Java;

**************************************************

See:

- « https://wiki.archlinux.org/index.php/desktop_entries »
- « https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html#recognized-keys »

*************************************************/