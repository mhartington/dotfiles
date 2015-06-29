# Source any other dot files
# Just .aliases right now git-completion.bash
  for file in ~/.{aliases,functions,keys,prompt}; do
    [ -r "$file" ] && source "$file"
  done
  unset file
  export TERMINAL_DARK=1
#  # export TERM="xterm-256color"
  export CLICOLOR=1
  BASE16_SHELL="$HOME/.config/base16-shell/base16-oceanicnext.dark.sh"
  [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
  export EDITOR=vi

  # sudo -V
# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
  # while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
  export _Z_DATA="$HOME/z-data"
  source ~/.z/z.sh

  alias journal=~/.journal.sh
  export JOURNAL_DIR="/Users/mhartington/Journal"

# This is for android crap
  export PATH=${PATH}:~/Library/Android/sdk/platform-tools:~/Library/Android/sdk/tools
  export JAVA_HOME=$(/usr/libexec/java_home)
  export PATH=${JAVA_HOME}/bin:$PATH
  export PATH=/usr/local/bin:$PATH

# Disable zsh autocorrect
  zstyle ':completion:*' menu select
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
  setopt completeinword
  zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash

# fpath=(~/.zsh/functions $fpath)
  fpath=(/usr/local/share/zsh-completions $fpath)
  autoload -U compinit && compinit
  zmodload -i zsh/complist
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

code () {
    VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*
  }
