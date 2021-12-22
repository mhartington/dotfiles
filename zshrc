#! /usr/bin/env zsh
#
#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
# [ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####
# Source any other dot files
# Just .aliases right now git-completion.bash
autoload -U promptinit; promptinit
bindkey -v
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

source /usr/local/share/antigen/antigen.zsh

# antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle marzocchi/zsh-notify
antigen bundle mafredri/zsh-async
antigen apply

source ~/.z/z.sh
# eval "$(zoxide init zsh)"

alias journal=~/.journal.sh
zstyle ':notify:*' command-complete-timeout 5
zstyle ':notify:*' error-icon "https://media3.giphy.com/media/10ECejNtM1GyRy/200_s.gif"
zstyle ':notify:*' error-title "Fail"
zstyle ':notify:*' success-icon "https://s-media-cache-ak0.pinimg.com/564x/b5/5a/18/b55a1805f5650495a74202279036ecd2.jpg"
zstyle ':notify:*' success-title "Success"

source ~/.prompt2


alias luamake=/Users/mhartington/Github/lua-language-server/3rd/luamake/luamake

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
# [ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####
