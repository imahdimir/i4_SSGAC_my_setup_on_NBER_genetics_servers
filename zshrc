###########################################################################
# Policies
# - I Use BULK=$HOME/bulk Python versions using pyenv
# - Installed pyenv in $HOME/bulk to save space in the 10GB home folder
###########################################################################


mycd()
{
  if [[ "$1" == "-" ]]; then
    cd "$@"
  else
    cd "$@" && pwd && ls
  fi
}
alias cd=mycd


# source SSGAC bashrc & export variables
source "/var/genetics/misc/config/.ssgac_bashrc"
source ".export"


alias cdws="cd $WS"
alias cdp="cd $PROJECTS_DATA"

alias cduws="cd $UKB_WS"
alias cdup="cd $UKB_PROJECTS_DATA"


# change default zsh prompt
DEFAULT_PROMPT=$PS1
PS1='[%3d] $ '


eval "$(pyenv init -)" # using eval to hide ouputs 
eval "$(pyenv virtualenv-init -)" # pyenv-virtualenv


# Just to see where I am
cd


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/miniconda/etc/profile.d/conda.sh" ]; then
        . "/usr/local/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

