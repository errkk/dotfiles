# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blinks"

DISABLE_AUTO_TITLE=true

plugins=(git virtualenvwrapper git-flow django fabric)

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8

source $ZSH/oh-my-zsh.sh

# Run .export if it exists
if [ -f $HOME/.export ] ; then source $HOME/.export ; fi

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/heroku/bin:/usr/local/Cellar/ruby/1.9.3-p0/bin:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local:/usr/local/sbin/:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin
source ~/.salt-poke/tools/update_check.sh
