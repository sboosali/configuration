##################################################
{ pkgs
, env
, sboo
}:

##################################################
let

ssh-agent = ''${pkgs.openssh}/bin/ssh-agent'';
ssh-add   = ''${pkgs.openssh}/bin/ssh-add'';

in
##################################################
''
#-----------------------------------------------#
# ssh-agent ------------------------------------#
#-----------------------------------------------#

if [ -x "$(command -v ${ssh-agent})" ]
then

    if   ! pgrep -x "ssh-agent" > /dev/null
    then eval "$(${ssh-agent} -s)"
    fi

    # ^ Start the « ssh-agent » in the background.

    if [ -f "~/.ssh/${sboo.keys.github}" ]
    then
        "${ssh-add}" ~/.ssh/${sboo.keys.github}
    fi

    # ^ Register my GitHub (@sboosali) key, via « ssh-agent ».
fi

#-----------------------------------------------#
''