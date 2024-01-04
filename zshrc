#! /usr/bin/env zsh
# zmodload zsh/zprof
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
##-end-ionic-completion-###
source <(npm completion)
# source <(ng completion script)
source /opt/homebrew/share/antigen/antigen.zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle marzocchi/zsh-notify
antigen bundle mafredri/zsh-async@main
antigen apply
#
source ~/.prompt2
source ~/.z/z.sh
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
