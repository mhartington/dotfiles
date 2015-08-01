# Source any other dot files
# Just .aliases right now git-completion.bash
# for file in ~/.{aliases,functions,prompt}; do
# 	[ -r "$file" ] && source "$file"
# done
# unset file

# This is for android crap
export PATH=${PATH}:~/Library/Android/sdk/platform-tools:~/Library/Android/sdk/tools
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=${JAVA_HOME}/bin:$PATH
export PATH=/usr/local/bin:$PATH

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
