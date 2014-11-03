# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="eric"

DISABLE_AUTO_TITLE=true

plugins=(git virtualenvwrapper git-flow django fabric git-hubflow github celery npm osx pip python)

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
source $ZSH/oh-my-zsh.sh

# Jump words
bindkey "[D" backward-word
bindkey "[C" forward-word

# Run .export if it exists
if [ -f $HOME/.export ] ; then source $HOME/.export ; fi

# Lots of PATH
export PATH=$PATH:/usr/local/git/bin:/usr/local/share/npm/bin

# Python Path
export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"

alias rs="django-admin.py runserver 0.0.0.0:9000"
alias gst="git status"
alias lg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias cpwd="pwd | tr -d '\n' | pbcopy"
source ~/.salt-poke/tools/update_check.sh
