#! /usr/bin/env zsh


autoload -U promptinit 
promptinit
source ~/.prompt2

bindkey -v
# Disable zsh autocorrect
autoload -Uz compinit

fpath=(/usr/local/share/zsh/site-functions $fpath)
fpath=(/usr/local/share/zsh-completions $fpath)

zmodload -i zsh/complist
setopt completeinword

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'


compinit

set editing-mode vi
set blink-matching-paren on

source <(npm completion)
source <(ng completion script)

# Antigen, zsh plugins
source /opt/homebrew/share/antigen/antigen.zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle mafredri/zsh-async@main
antigen bundle agkozak/zsh-z
antigen apply

zstyle ':notify:*' command-complete-timeout 5
zstyle ':notify:*' error-title "Fail"
zstyle ':notify:*' success-title "Success"
# zprof

# bun completions
[ -s "/Users/mhartington/.bun/_bun" ] && source "/Users/mhartington/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
