##################################################
{ pkgs

, sboo

# , xdg 
}:
##################################################
{

"ga," = "git add .";
"gau" = "git add -u";

"gc"  = "git commit";
"gcm" = "git commit -m";
"gc." = "git commit -m .";

alert = ''notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')"'';

# ^ « notify-send »:
#
# for long running commands. Usage: « sleep 10; alert "OPTIONAL MESSAGE" »

ll=''ls -alF'';
la=''ls -A'';
lc=''ls -CF'';

# ^ « ls »

sa   = ''. ~/.aliases'';
sba  = ''. ~/.bash_aliases'';
sbrc = ''. ~/.bashrc'';

sbc-usr  = ''. /usr/share/bash-completion/bash_completion'';
sbc-etc  = ''. /etc/bash_completion'';

# ^ "s" prefix for "source".
# 

}
##################################################