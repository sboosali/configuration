##################################################
{ sboo
, applications
}:

##################################################
{
 #-----------------------------#
 # fonts...

 "fonts/iosevka".source    = ../../../fonts/iosevka/ttf;
 "fonts/iosevka".recursive = true;

 "fonts/dejavu".source    = ../../../fonts/dejavu/ttf;
 "fonts/dejavu".recursive = true;

 "fonts/noto".source    = ../../../fonts/noto/ttf;
#"fonts/noto".source    = ../../../fonts/noto/otf;
 "fonts/noto".recursive = true;

 "fonts/quivira".source    = ../../../fonts/quivira/otf;
 "fonts/quivira".recursive = true;

 "fonts/symbola".source    = ../../../fonts/symbola/ttf;
#"fonts/symbola".source    = ../../../fonts/symbola/ttf;
 "fonts/symbola".recursive = true;

 # "fonts/all-the-icons".source    = ../../../fonts/all-the-icons/ttf;
 # "fonts/all-the-icons".recursive = true;

 #-----------------------------#
 # applications...

 "applications/emacs.desktop".text         = applications.emacs.desktop;
 "applications/google-chrome.desktop".text = applications.google-chrome.desktop;

 #-----------------------------#
 # completion...

 "bash/completions".source    = ../../../bash/completion;
 "bash/completions".recursive = false;

#"zsh/completions".recursive  = false;
#"fish/completions".recursive = false;

 #-----------------------------#

#TODO# ".aspell.en.pws".source = ../../../data/aspell/en.pws;

 # « ~/.aspell.en.pws » is the default (non-XDG-conformant) location for an English-language Personal Dictionary.

 #-----------------------------#
 # ...

 

 #-----------------------------#
}
##################################################