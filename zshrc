# Source any other dot files
# Just .aliases right now git-completion.bash
  for file in ~/.{aliases,functions,keys,prompt}; do
    [ -r "$file" ] && source "$file"
  done
  unset file
  bindkey -v
  export KEYTIMEOUT=1
  export TERMINAL_DARK=1
  export CLICOLOR=1
  export EDITOR=nvim
  # export BREW_PATH=$(brew --prefix)
  export GOPATH=$HOME/go
  export _Z_DATA="$HOME/z-data"
  source ~/.z/z.sh
  alias journal=~/.journal.sh
  export JOURNAL_DIR="/Users/mhartington/Journal"
  export NVIM_PYTHON_LOG_FILE=/tmp/log
  export NVIM_PYTHON_LOG_LEVEL=DEBUG
# This is for android crap
  export PATH=${PATH}:~/Library/Android/sdk/platform-tools:~/Library/Android/sdk/tools
  export JAVA_HOME=$(/usr/libexec/java_home)
  export PATH=${JAVA_HOME}/bin:$PATH
  export PATH=/usr/local/bin:$PATH
  export PATH=${PATH}:~/bin
  export ANDROID_HOME=~/Library/Android/sdk
  export PATH=$PATH:$GOPATH/bin

# Disable zsh autocorrect
  zstyle ':completion:*' menu select
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
  setopt completeinword
  zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash

  set editing-mode vi
  set blink-matching-paren on

  fpath=(/usr/local/share/zsh-completions $fpath)
  autoload -U compinit && compinit
  zmodload -i zsh/complist
  . <(npm completion)
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

  # Setting ag as the default source for fzf
  export FZF_DEFAULT_COMMAND='ag --nocolor --ignore .git --ignore *.png --ignore lib -l -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  export ZLE_RPROMPT_INDENT=0
  export BULLETTRAIN_TIME_SHOW=false
  export BULLETTRAIN_STATUS_SHOW=false
  export BULLETTRAIN_PROMPT_ADD_NEWLINE=false
  export DISABLE_AUTO_TITLE=true
  source ~/antigen/antigen.zsh
  # antigen use oh-my-zsh
  # antigen theme cloud
  antigen bundle zsh-users/zsh-syntax-highlighting
  # antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train
  # Tell antigen that you're done.
  antigen apply

