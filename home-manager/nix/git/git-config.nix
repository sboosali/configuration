##################################################
{ pkgs

#, sboo
}:

##################################################
let

less = "${pkgs.less}/bin/less";

in
##################################################
{

 core.filemode = false;

 core.autocrlf = false;

 # ^ « autocrlf = false » means:
 # TODO
 # 
 # 

 # ^ « autocrlf = input » means:
 # convert CRLF to LF on commit i.e. "input"
 # (don't convert LF to CRLF on checkout).

 core.pager = "${less} --tabs=4 -RFX";

 # ^ a blank `pager` means: no pager.

 # ^ « less -R -F -X » means:
 # TODO

 core.whitespace = "trailing-space";

 # ^ "trailing-(white)space" means: TODO.

 #editor = emacsclient

 # ^ « $GIT_EDITOR -> core.editor -> $VISUAL -> $EDITOR »

 #################################################

 merge.conflictstyle = "diff3";
 merge.stat          = true;

 #################################################

 submodule.recurse = true;

 #################################################

 color.status      = "auto";
 color.diff        = "auto";
 color.branch      = "auto";
 color.interactive = "auto";
 color.ui          = "auto";
 color.sh          = "auto";

 #################################################

 #################################################

 #################################################

 github.user = "sboosali";

 #################################################

#TODO# credential.helper = osxkeychain;

}
##################################################