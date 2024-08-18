###########################################################################

# DropBox Setup: Installed Maestral in "maestral_venv" for syncing with 
# selective functionality

# Policies
# - I Use BULK=$HOME/bulk Python versions using pyenv
# - Installed pyenv in $HOME/bulk to save space in the 10GB home folder
# - $WS for DropBox + Local Data (Porjects Data + Non_Project Data)

###########################################################################

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
  echo "INFO: Updating pip & maestral in maestral_venv"
  pyenv activate maestral_venv
  pip install --upgrade pip maestral -q
  maestral status
  pyenv deactivate
}

start_maestral()
{
  echo "INFO: Starting maestral from maestral_venv"
  pyenv activate maestral_venv
  maestral start
  maestral status
  pyenv deactivate
}

restart_maestral() 
{
  echo "INFO: Restarting Maestral"
  pyenv activate maestral_venv
  maestral stop
  maestral start
  maestral status
  pyenv deactivate
}

# I disabled maestral autostart to avoid error on start 
# and multiple start on different hosts
start_maestral_on_login() 
{
  while true; do
    # Capture maestral status
    output=$(get_maestral_status 2>&1)

    # Check if the error message is in the output
    if echo "$output" | grep -q "Database transaction error"; then
        restart_maestral
        sleep 1  # Wait 1 second before checking again, to avoid overwhelming the system
    elif echo "$output" | grep -q "Maestral daemon is not running."; then
        start_maestral
        sleep 1
    else
        echo "INFO: No error detected, Maestral is running, Exiting the loop."
        break  # Exit the loop if the error is no longer present
    fi
  done
}


##################################################


alias cd=mycd

alias cdw="mycd $WS"
alias cdx="mycd $DBX"
alias cdc="mycd $CODE"
alias cdl="mycd $LOCAL"
alias cdp="mycd $PRJ_DATA_LOCAL/24Q3/"


##################################################


# source SSGAC bashrc & export variables
source "/var/genetics/misc/config/.ssgac_bashrc"
source ".export"


DEFAULT_PROMPT=$PS1
PS1='[%3d] $ '


eval "$(pyenv init -)" # using eval to hide ouputs 
# pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"


start_maestral_on_login