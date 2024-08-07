#############################################################################

# DropBox Setup: Installed Maestral in "maestral_venv" for syncing with 
# selective functionality

# Policies
# - I Use BULK=$HOME/bulk Python versions using pyenv
# - Installed pyenv in $HOME/bulk to save space in the 10GB home folder
# - $WS for DropBox + Local Data (Porjects Data + Non_Project Data)

#############################################################################

mycd()
{
  if [[ "$1" == "-" ]]; then
    cd "$@"
  else
    cd "$@" && pwd
  fi
}

get_maestral_status() 
{
  pyenv activate maestral_venv
  maestral status
  pyenv deactivate
}

update_maestral() 
{
  pyenv activate maestral_venv
  echo "Updating pip & maestral in maestral_venv"
  pip install --upgrade pip maestral -q
  maestral status
  pyenv deactivate
}

restart_maestral() 
{
  pyenv activate maestral_venv
  echo "Restarting Maestral"
  maestral stop
  maestral start
  maestral status
  pyenv deactivate
}

update_maestral_on_fri()
{
day_of_week=$(date +%u)  # 1=Monday, ..., 5=Friday, ..., 7=Sunday

if [ "$day_of_week" -eq 5 ];
then
    echo "Updating maestral"
    update_maestral
else
    echo "Today is not Friday, No update to maestral."
fi
}

###################################

alias cd=mycd

alias cdw="mycd $WS"
alias cdx="mycd $DBX"
alias cdc="mycd $CODE"
alias cdl="mycd $LOCAL"
alias cdp="mycd $PRJ_DATA_LOCAL/24Q3"

###################################

# update .export & tcshrc from GitHub base
wget -O .export https://raw.githubusercontent.com/imahdimir/NBER_Genetics_Servers_tcshrc/master/export
wget -O .tcshrc https://raw.githubusercontent.com/imahdimir/NBER_Genetics_Servers_tcshrc/master/tcshrc
wget -O .zshrc https://raw.githubusercontent.com/imahdimir/NBER_Genetics_Servers_tcshrc/master/zshrc


# source SSGAC bashrc & export variables
source "/var/genetics/misc/config/.ssgac_bashrc"
source ".export"


DEFAULT_PROMPT=$PS1
PS1='[%3d] $ '


eval "$(pyenv init -)" # using eval to hide ouputs 
# pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"


update_maestral_on_fri
get_maestral_status