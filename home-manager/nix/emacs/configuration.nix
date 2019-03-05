##################################################
{}:

##################################################
let



in
##################################################
rec {

 haskell-mode.repo = "melpa";

 magit.tools = pkgs: with pkgs; [ gitAndTools ];
 magit.elisp = ''
 (require 'magit)
 '';

 intero.tools = pkgs: with pkgs; [ haskellPackages.stack ];
 intero.elisp = ''
 (require 'intero)
 (add-hook 'haskell-mode-hook 'intero-mode)
 #(remove-hook 'haskell-mode-hook 'dante-mode)
 '';

 # direnv.tools = with pkgs; [ direnv ];
 # direnv.elisp = ''
 # (require 'direnv)
 # '';

}
##################################################
/* "Templates"

##############################

 _.tools = pkgs: with pkgs; [ _ ];
 _.repo  = "";
 _.elisp = ''
 (require '_)
 '';

##############################

*/
##################################################
/* Notes

« repo » is an enum, corresponding to:

- emacs26PackagesNg.elpaPackages
- emacs26PackagesNg.melpaPackages
- emacs26PackagesNg.melpaStablePackages
- 

##############################

##############################

*/
##################################################