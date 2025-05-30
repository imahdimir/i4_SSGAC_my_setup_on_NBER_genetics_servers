###########################################################################
# Policies
# - I Use BULK=$HOME/bulk Python versions using pyenv
# - Installed pyenv in $HOME/bulk to save space in 10GB home folder
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

# quick way to go to tmp_code_dir that is synced with local code dir to run codes faster
gotmp_code_dir() {
  if [[ -n "$tmp_code_dir" ]]; then
    cd "$tmp_code_dir"
  else
    echo "tmp_code_dir is not set."
  fi
}

# quick cd to proj_data_dir
goproj_data_dir(){
  if [[ -n "$proj_data_dir" ]]; then
    cd "$proj_data_dir"
  else
    echo "proj_data_dir is not set."
  fi
}


# source SSGAC bashrc & export variables
source "/var/genetics/misc/config/.ssgac_bashrc"
source ".export"


alias cduws="cd $UKB_WS"
alias cdup="cd $UKB_PROJECTS_DATA"

alias cdws="cd $WS"
alias cdp="cd $PROJECTS_DATA"


# change default zsh prompt
DEFAULT_PROMPT=$PS1
PS1='[%3d] $ '


eval "$(pyenv init -)" # using eval to hide ouputs 
eval "$(pyenv virtualenv-init -)" # pyenv-virtualenv


# Add PLINK to PATH
#export PATH="/homes/nber/alextisyoung/plink:$PATH"
#Wasn't successful adding to PATH so I just created an alias to bypass this problem
#alias plink=/homes/nber/alextisyoung/plink


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/usr/local/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/usr/local/miniconda/etc/profile.d/conda.sh" ]; then
#        . "/usr/local/miniconda/etc/profile.d/conda.sh"
#    else
#        export PATH="/usr/local/miniconda/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<
