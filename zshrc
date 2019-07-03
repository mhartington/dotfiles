#! /usr/bin/env zsh
# Source any other dot files
# Just .aliases right now git-completion.bash
autoload -U promptinit; promptinit
bindkey -v
source ~/.prompt2
# Disable zsh autocorrect
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt completeinword
zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash

set editing-mode vi
set blink-matching-paren on
fpath=(/usr/local/share/zsh/site-functions $fpath)
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit && compinit

zmodload -i zsh/complist
compinit -d ~/.zcompdump_capture
###-begin-ionic-completion-###

if type compdef &>/dev/null; then
  __ionic() {
    compadd -- $(ionic completion -- "${words[@]}" 2>/dev/null)
  }

  compdef __ionic ionic
fi

###-end-ionic-completion-###
. <(npm completion)

# Load rbenv automatically by appending
# the following to ~/.zshrc:

eval "$(rbenv init -)"
source ~/.iterm2_shell_integration.zsh
source /usr/local/share/antigen/antigen.zsh

# antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
# antigen bundle marzocchi/zsh-notify
antigen bundle mafredri/zsh-async
# antigen theme eendroroy/alien alien
# antigen bundle sindresorhus/pure
antigen apply

source ~/.z/z.sh
alias journal=~/.journal.sh
zstyle ':notify:*' command-complete-timeout 5
zstyle ':notify:*' error-icon "https://media3.giphy.com/media/10ECejNtM1GyRy/200_s.gif"
zstyle ':notify:*' error-title "Fail"
zstyle ':notify:*' success-icon "https://s-media-cache-ak0.pinimg.com/564x/b5/5a/18/b55a1805f5650495a74202279036ecd2.jpg"
zstyle ':notify:*' success-title "Success"

# source ~/.dark_mode.sh
