# rest added by Mahdi

export MAHDI_BULK="$HOME/bulk"
export MAHDI_DIR="/var/genetics/ws/mahdimir"
export MAHDI_DROPBOX="$MAHDI_DIR/DropBox"
export MAHDI_ALL="$MAHDI_DROPBOX/0-all"
export MAHDI_GIT="$MAHDI_ALL/0-git-all"


# <<< pyenv <<<

export PYENV_ROOT="$MAHDI_BULK/.pyenv"
export PATH="$PATH:$PYENV_ROOT/bin"
eval "$(pyenv init -)" # using eval to hide ouputs 

# <<< 


# <<< pyenv-virtualenv

eval "$(pyenv virtualenv-init -)"

# <<<


# <<< plink2

export PATH="$PATH:~/disk/genetics/tools/plink2/plink2"

# <<<
