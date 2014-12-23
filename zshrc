ZLE_RPROMPT_INDENT=0

# Source any other dot files
# Just .aliases right now
  for file in ~/.{aliases,functions,prompt}; do
    [ -r "$file" ] && source "$file"
  done
  unset file


# This is for android crap
  export PATH=${PATH}:/Applications/Android\ Studio.app/sdk/platform-tools:/Applications/Android\ Studio.app/sdk/tools
  export JAVA_HOME=$(/usr/libexec/java_home)
  export PATH=${JAVA_HOME}/bin:$PATH
  export PATH=/usr/local/bin:$PATH

# User homebrew version of python
  export PATH=$PATH:~/python2.7/bin
#
# # Powerline-shell
#   function powerline_precmd() {
#     export PS1="$(~/powerline-shell/powerline-shell.py $? --shell zsh 2> /dev/null)"
#   }
#
#   function install_powerline_precmd() {
#     for s in "${precmd_functions[@]}"; do
#       if [ "$s" = "powerline_precmd" ]; then
#         return
#       fi
#     done
#     precmd_functions+=(powerline_precmd)
#   }
#
#   install_powerline_precmd


# Powerline for zsh
# Config in ./.config/powerline
# .  /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
