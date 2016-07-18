function strip_diff_leading_symbols(){
    color_code_regex=$'(\x1B\\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K])'

        # simplify the unified patch diff header
        sed -E "s/^($color_code_regex)diff --git .*$//g" | \
               sed -E "s/^($color_code_regex)index .*$/\
  \1$(rule)/g" | \
               sed -E "s/^($color_code_regex)\+\+\+(.*)$/\1\+\+\+\5\\
  \1$(rule)/g" | \

        # actually strips the leading symbols
               sed -E "s/^($color_code_regex)[\+\-]/\1 /g"
}

## Print a horizontal rule
rule () {
        printf "%$(tput cols)s\n"|tr " " "─"
      }
function code () {
  VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*
}
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $(git_custom_status) $EPS1"
    zle reset-prompt
  }

export KEYTIMEOUT=1
export TERMINAL_DARK=1
export TERM=xterm-256color-italic
export CLICOLOR=1
export EDITOR=nvim
# export BREW_PATH=$(brew --prefix)
export GOPATH=$HOME/go
export _Z_DATA="$HOME/z-data"
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

export FZF_DEFAULT_COMMAND='ag --nocolor --ignore .git --ignore *.png --ignore lib -l -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export ZLE_RPROMPT_INDENT=0
export BULLETTRAIN_TIME_SHOW=false
export BULLETTRAIN_STATUS_SHOW=false
export BULLETTRAIN_PROMPT_ADD_NEWLINE=false
export DISABLE_AUTO_TITLE=true

export EVENT_NOKQUEUE=1
