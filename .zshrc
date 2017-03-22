source "$HOME/.slimzsh/slim.zsh"

alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
#
# Path to your oh-my-zsh configuration.

#ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
#ZSH_THEME="eric"

#DISABLE_AUTO_TITLE=true

#plugins=(git virtualenvwrapper git-flow django fabric git-hubflow github celery npm osx pip python emoji-clock heroku docker docker-compose emmoji)

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export REACT_EDITOR=mvim
export EDITOR=nvim

#source $ZSH/oh-my-zsh.sh

# Jump words
bindkey "[D" backward-word
bindkey "[C" forward-word

# Run .export if it exists
if [ -f $HOME/.export ] ; then source $HOME/.export ; fi

# Lots of PATH
export PATH=$PATH:/usr/local/git/bin:/usr/local/bin
export PATH=$HOME/.node/bin:$PATH
export PATH="$PATH:`yarn global bin`"

# Android stuffs
export ANDROID_HOME=${HOME}/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

# Python Path
export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"

alias gst="git status"
alias lg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias cpwd="pwd | tr -d '\n' | pbcopy"
export NVM_DIR="/Users/eric/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

eval "$(rbenv init -)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

