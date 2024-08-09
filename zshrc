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
  pyenv activate maestral_venv
  echo "Updating pip & maestral in maestral_venv"
  pip install --upgrade pip maestral -q
  maestral status
  pyenv deactivate
}

start_maestral()
{
  pyenv activate maestral_venv
  maestral start
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

remind_updating_maestral_on_fri()
{
  day_of_week=$(date +%u)  # 1=Monday, ..., 5=Friday, ..., 7=Sunday

  if [ "$day_of_week" -eq 5 ];
    then
        echo "Today is Friday, reminder: Update maestral by 'update_maestral'."
  fi
}

# I disabled maestral autostart to avoid error on start 
# and multiple start on different hosts
start_maestral_if_host_is_g03() 
{

  if [[ "$(hostname)" == "g03" ]];
    then

        start_maestral
      
        while true; 
        do
          # Run the command and capture its output
          output=$(get_maestral_status 2>&1)
          
          # Check if the error message is in the output
          if echo "$output" | grep -q "Database transaction error"; then
              restart_maestral
              # Optionally, you can add a sleep command to avoid overwhelming the system
              sleep 10  # Wait 10 seconds before checking again
          else
              echo "No error detected. Exiting the loop."
              break  # Exit the loop if the error is no longer present
          fi
      
        done

    else
    
        echo "Hostname is $(hostname), not 'g03'. start_maestral will not run."
        get_maestral_status
  fi
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


remind_updating_maestral_on_fri
start_maestral_if_host_is_g03
