##################################################
{ 
# , initFile      ? null
# , initDirectory ? null
}:

#TODO:
# { Exec
# , Path
# }:

#TODO:
# { program
# , executable
# , directory
# }:

##################################################
let

fromPath = builtins.toString;

##################################################

emacs   = fromPath ~/.nix-profile/bin/emacs;

emacs-d = fromPath ~/.emacs.d;

#[TODO rm] emacs = ''${config.emacs}/bin/emacs'';

in
##################################################
''
##################################################
[Desktop Entry]
Version=1.0
Type=Application
Encoding=UTF-8

Name=emacs
#TODO Name=【E】 emacs

#############################

Exec=${emacs} --maximized --name=SBoo %F
TryExec=emacs
Path=${emacs-d}

# ^ %F interpolates a list of filenames.

#############################

MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;

Icon=emacs # TODO ../icons/128x128/emacs.png

Categories=Development;TextEditor;
Keywords=Text;Editor;

GenericName=Text Editor
Comment=Edit text

StartupWMClass=Emacs
StartupNotify=false
Terminal=false

#############################

Actions=debug;

##################################################
[Desktop Action debug]

Name=【D】 Debug Emacs « --debug-init ».

Exec=${emacs} --debug-init --find-file=~/.emacs.d/init.el --no-splash --name=SBoo/Debug %F
TryExec=emacs
Path=${emacs-d}

##################################################
# Notes ##########################################
##################################################

# the field codes are:
#
# %f	A single file name (including the path), even if multiple files are selected. The system reading the desktop entry should recognize that the program in question cannot handle multiple file arguments, and it should should probably spawn and execute multiple copies of a program for each selected file if the program is not able to handle additional file arguments. If files are not on the local file system (i.e. are on HTTP or FTP locations), the files will be copied to the local file system and %f will be expanded to point at the temporary file. Used for programs that do not understand the URL syntax.
#
# %F	A list of files. Use for apps that can open several local files at once. Each file is passed as a separate argument to the executable program.
#
# %u	A single URL. Local files may either be passed as file: URLs or as file path.
#
# %U	A list of URLs. Each URL is passed as a separate argument to the executable program. Local files may either be passed as file: URLs or as file path.
#
# %i	The Icon key of the desktop entry expanded as two arguments, first --icon and then the value of the Icon key. Should not expand to any arguments if the Icon key is empty or missing.
#
# %c	The translated name of the application as listed in the appropriate Name key in the desktop entry.
#
# %k	The location of the desktop file as either a URI (if for example gotten from the vfolder system) or a local filename or empty if no location is known. 
#

# See https://standards.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html#exec-variables .

#TODO  --load ~/.emacs.d/init.el

##################################################
''