##################################################
{ pkgs
, sboo
, xdg
}:

# NOTE `bash`-specfic environment-variables.
# for `sh`-general environment-variables, see « ../home/environment-variables.nix ».

##################################################
let

less = ''${pkgs.less}/bin/less'';

in
##################################################
{

PAGER = less;


}
##################################################
