# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="blinks"
ZSH_THEME="eric"

DISABLE_AUTO_TITLE=true

plugins=(git virtualenvwrapper git-flow django fabric git-hubflow github celery npm osx pip python)

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8

source $ZSH/oh-my-zsh.sh

# Jump words
bindkey "[D" backward-word
bindkey "[C" forward-word

# Run .export if it exists
if [ -f $HOME/.export ] ; then source $HOME/.export ; fi

# Customize to your needs...
export PATH=/usr/local/heroku/bin:/usr/local/Cellar/ruby/1.9.3-p0/bin:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local:/usr/local/sbin/:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:$HOME/bin:/usr/local/share/npm/bin/:$PATH
source ~/.salt-poke/tools/update_check.sh
alias rs="django-admin.py runserver 0.0.0.0:9000"
alias gst="git status"
pr() {hub pull-request -b pokelondon:develop -h pokelondon:feature/issue-"$1" -i "$1" }
alias lg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias cpwd="pwd | tr -d '\n' | pbcopy"
source $(brew --prefix nvm)/nvm.sh
ansiweather

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=/usr/local/bin:$PATH
