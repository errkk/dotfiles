export PURE_PROMPT_SYMBOL="✨ "

source "$HOME/.slimzsh/slim.zsh"

alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

alias ls='exa'

alias be='bundle exec'
alias ez='nvim ~/.zshrc'
alias sz='source ~/.zshrc'
alias sv='source venv/bin/activate'
alias tf='terraform'
alias kb='kubectl'
alias dc='docker-compose'
alias dce='docker-compose exec'
alias gpu="git rev-parse --abbrev-ref HEAD | xargs git push -u origin" # push new branch to origin
alias uncommit="git reset HEAD^"
alias gdmb='git branch --merged | egrep -v "(^\*|master|dev|develop|develop-group-leave)" | xargs git branch -d'
alias gf='git fuzzy'
alias gfs='git fuzzy status'
alias pes='pipenv shell'
alias ll='ls -alh -snew'

commas () {
  pbpaste | gsed '$!s/$/,/' | cat
}
lamp () {
  curl -s http://relays.local/cm?cmnd=Power1%20TOGGLE | jq '.POWER1' | sed -e 's/\"OFF\"/🙅/' -e 's/\"ON\"/💡/'
}
block () {
  curl -s http://relays.local/cm?cmnd=Power3%20TOGGLE | jq '.POWER1' | sed -e 's/\"OFF\"/🙅/' -e 's/\"ON\"/💡/'
}
desk () {
  curl -s http://desk.local/cm?cmnd=Power%20TOGGLE | jq '.POWER1' | sed -e 's/\"OFF\"/🙅/' -e 's/\"ON\"/💡/'
}

longlight () {
  curl -s http://longlight.local/cm?cmnd=Power%20TOGGLE | jq '.POWER1' | sed -e 's/\"OFF\"/🙅/' -e 's/\"ON\"/💡/'
}

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export REACT_EDITOR=nvim
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
alias wevs='curl -s 'wttr.in/London?m1""

# NVM
export NVM_DIR="/Users/eric/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/Users/ericgeorge/Development/checkouts/git-fuzzy/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

# rbenv
eval "$(rbenv init -)"
