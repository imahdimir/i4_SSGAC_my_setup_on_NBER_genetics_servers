: '
Shell Configuration
- Default shell on Genetic NBER servers: tcsh (runs .tcshrc on start).
- Switch to zsh upon login (with .tcshrc) then zsh runs .zshrc automatically.


DropBox Setup
- Installed Maestral in "maestral_venv" for syncing with selective functionality.
- Enabled Maestral autostart for its daemon.
- Use different setups to determine sync between computers.

Management
- Use BULK=$HOME/bulk for software installations, Python versions, venvs, and auto-managed items.
- Installed pyenv in $HOME/bulk to save space in the 10GB home folder.
- pyenv to install/manage python versions
- pyenv virtualenv for manage python venvs
- Personal Workspace ($WS) for DropBox + Local Data(Porjects Data + Non_Project Data).
'


source "/var/genetics/misc/config/.ssgac_bashrc"
source ".export"


alias cdw="mycd $WS"
alias cdx="mycd $DBX"
alias cdc="mycd $CODE"
alias cdl="mycd $LOCAL"
alias cdp="mycd $PRJ_DATA_LOCAL"


mycd() {
  if [[ "$1" == "-" ]]; then
    cd "$@"
  else
    cd "$@" && pwd
  fi
}
alias cd=mycd

get_maestral_status(){
  pyenv activate maestral_venv
  maestral status
  pyenv deactivate
}

update_maestral(){
  pyenv activate maestral_venv
  echo "Updating pip & maestral in maestral_venv"
  pip install --upgrade pip maestral -q
  maestral status
  pyenv deactivate
}

update_shell_config() {
  cd ~/G_zshrc

  git reset --hard HEAD
  git pull

  cp ./.tcshrc ~/.tcshrc
  cp ./.zshrc ~/.zshrc
  cp ./.export ~/.export

  exec $SHELL
}

update_ev_thing(){
  update_shell_config
  update_maestral
}


DEFAULT_PROMPT=$PS1
PS1=">"


eval "$(pyenv init -)" # using eval to hide ouputs 
# pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"


get_maestral_status