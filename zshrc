# Source any other dot files
# Just .aliases right now git-completion.bash
for file in ~/.{aliases,functions,prompt}; do
    [ -r "$file" ] && source "$file"
  done
  unset file

  export EDITOR=vi

  alias journal=~/.journal.sh
  export JOURNAL_DIR="/Users/mhartington/Journal"
# git autocomplete
# This is for android crap
  export PATH=${PATH}:~/Library/Android/sdk/platform-tools:~/Library/Android/sdk/tools
  export JAVA_HOME=$(/usr/libexec/java_home)
  export PATH=${JAVA_HOME}/bin:$PATH
  export PATH=/usr/local/bin:$PATH

# Disable zsh autocorrect
  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
  fpath=(~/.zsh/functions $fpath)
  autoload -U compinit && compinit
  zmodload -i zsh/complist

  source .zsh-syntax-highlighting.zsh
