#   The default shell on genetics server is "tcsh" (which runs user's .tcshrc on start)
#   
#   I update .tsch(self update) and .zshrc from GitHub base upon login.
#   Then I switch shell to zsh (current .zshrc will be automatically run)

#   DropBox
#       Installed "pip install Maestral" in an isolated and exclusive Maestral app on the server, 
#       it has its deamon and ignoring and selective sync functionality
#       I have different setups to determine what should be synced between which computers
#       
#       Deamon: I enable Maestral autostart feature.

#   I use $HOME/bulk for installing softwares, python versions, venvs and these kind of manged by pkg manager and not clean stuff but automatically managed stuff
#   I use my personal genetics folder defined below as $MAHDI_DIR for having the DropBox folder, all the code in git format in the and anyother output if I wanted them to get synced I use the DropBox folder
#   
#   I installed the pyenv in the .pyenv in the bulk folder so installing new python versions and pyenvs don't use my 10GB home folder space
#       no need to sudo to install pyenv just git clone the repo
#       I use pyenv to install anyversion of python (even maybe conda versions) and creating and managing the venvs
#       To create venvs the pyenv-virtualenv which is plugin to pyenv must be setup
#   
#   
#
#   Completions
#       TODO: make maestral completion work
#       I made the ~/.zsh/completion dir for storing completion.
#       I added the completion code for the maestral to the dir.
# > completions
# to load completion files from the path
# fpath=(~/.zsh/completion $fpath)
# autoload -U compinit
# compinit
#



# SSGAC .bashrc: has useful ENV Vars like GEN_ROOT
# source runs in the current shell unlike the bash command which creates a subshell
source "/var/genetics/misc/config/.ssgac_bashrc"

# revert back to original zsh prompt
PS1=$DEFAULT_PROMPT


mycd() {
  if [[ "$1" == "-" ]]; then
    cd "$@"
  else
    cd "$@" && pwd
  fi
}

alias cd=mycd


source ".export"


# pyenv
export PYENV_ROOT="$BULK/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin"
eval "$(pyenv init -)" # using eval to hide ouputs 

# pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"

# Maestral DropBox status check
pyenv activate maestral_venv
echo "Updating pip & maestral in maestral_venv"
pip install --upgrade pip maestral -q
maestral status
pyenv deactivate