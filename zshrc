# if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
#   source "$HOME/.sdkman/bin/sdkman-init.sh"
# fi

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
source "/opt/homebrew/share/antigen/antigen.zsh"
# antigen bundle zsh-users/zsh-autosuggestions
antigen bundle mafredri/zsh-async@main
antigen bundle agkozak/zsh-z
antigen apply

zstyle ':notify:*' command-complete-timeout 5
zstyle ':notify:*' error-title "Fail"
zstyle ':notify:*' success-title "Success"
# zprof

[ -s "/Users/mhartington/.bun/_bun" ] && source "/Users/mhartington/.bun/_bun"
