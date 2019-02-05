##################################################
{ pkgs
, utilities
}:

##################################################
let

in
##################################################

with utilities;

##################################################
let

configurations = rec {

intero.tools = stack;
intero.elisp = ''
(package-install 'intero)
(add-hook 'haskell-mode-hook 'intero-mode)
'';

};

in
##################################################

configurations

##################################################