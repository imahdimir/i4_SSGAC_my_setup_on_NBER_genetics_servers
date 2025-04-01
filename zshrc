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
    cd "$@" && pwd
  fi
}
alias cd=mycd


# source SSGAC bashrc & export variables
source "/var/genetics/misc/config/.ssgac_bashrc"
source ".export"


alias cdw="cd $WS"
alias cdp="cd $PROJECTS_DATA"


# change default zsh prompt
DEFAULT_PROMPT=$PS1
PS1='[%3d] $ '


eval "$(pyenv init -)" # using eval to hide ouputs 
eval "$(pyenv virtualenv-init -)" # pyenv-virtualenv
