# Source any other dot files
# Just .aliases right now git-completion.bash
for file in ~/.{aliases,functions,keys,prompt}; do
  [ -r "$file" ] && source "$file"
done
unset file
bindkey -v

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
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setting ag as the default source for fzf
source ~/antigen/antigen.zsh
# antigen use oh-my-zsh
# antigen theme cloud
antigen bundle zsh-users/zsh-syntax-highlighting
# antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train
antigen bundle zsh-users/zsh-autosuggestions
# antigen bundle marzocchi/zsh-notify
antigen apply

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
zstyle ':notify:*' notifier /usr/local/bin/terminal-notifier
zstyle ':notify:*' error-sound "Glass"
zstyle ':notify:*' success-sound "default"

source ~/.z/z.sh
alias journal=~/.journal.sh
