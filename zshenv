export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
# source ~/.keys
# export MACOSX_DEPLOYMENT_TARGET=10.14
export KEYTIMEOUT=1
export CLICOLOR=1
export EDITOR=nvim
export _Z_DATA="$HOME/z-data"
export ITERM_24BIT=1
export DISABLE_AUTO_TITLE="true"

# Load rbenv automatically by appending
# the following to ~/.zshrc:
# export PATH="$HOME/.rbenv/bin:$PATH"
# export PATH="$HOME/.rbenv/shims:$PATH"


export PATH=/usr/local/bin:$PATH
export PATH=${PATH}:~/bin
# export BREW_PATH=$(brew --prefix)
export PATH=${PATH}:~/bin/nvim/bin



# Python...amiright
# export PATH="/usr/local/opt/python@3.7/bin:$PATH"
export PATH="/Users/mhartington/.local/bin:$PATH"


# Java setup

export GRADLE_HOME=$BREW_PATH
# export ANDROID_NDK_HOME="/usr/local/share/android-ndk"
# export ANDROID_HOME=/usr/local/share/android-sdk
# export PATH=$PATH:$ANDROID_HOME/platform-tools/:$ANDROID_HOME/emulator

# new android setup?
export ANDROID_SDK_ROOT=~/Library/Android/sdk
export ANDROID_HOME=~/Library/Android/sdk


export PATH=$PATH:$ANDROID_HOME/platform-tools/:$ANDROID_HOME/emulator
export PATH=$ANDROID_HOME:$PATH

export AVD=/usr/local/bin/avdmanager
export PATH=$AVD:$PATH

export SDK_MANAGER=/usr/local/bin/sdkmanager
export PATH=$SDK_MANAGER:$PATH

export ADB=/usr/local/bin/adb
export PATH=$ADB:$PATH

# export PATH=$ANDROID_NDK:$PATH
export PATH=$PATH:$GRADLE_HOME/bin
export PATH=$JAVA_HOME/bin:$PATH

# This is for android crap
# I dont know if I can delete this stuff yet.
# export PATH="/usr/local/opt/openjdk/bin:$PATH"
# export PATH=${PATH}:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools
# export PATH=${PATH}:$ANDROID_HOME/tools/bin/avdmanager:$ANDROID_HOME/tools/bin/sdkmanager
# export PATH=$ANDROID_HOME/emulator:$PATH

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/python@2/bin:$PATH"

# export PATH="$(brew --prefix gettext)/bin:$PATH"
# export CFLAGS="-I/usr/local/opt/openssl/include $CFLAGS"
# export LDFLAGS="-L/usr/local/opt/openssl/lib $LDFLAGS"
# export LDFLAGS="-Wl,-headerpad_max_install_names ${LDFLAGS}"

# Ruby
# export PATH="/usr/local/opt/ruby/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/ruby/lib"
# export CPPFLAGS="-I/usr/local/opt/ruby/include"
# export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"
#

export RUST_SRC_PATH=$HOME/.cargo/bin
export PATH=$PATH:$RUST_SRC_PATH

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin



# export PATH="/usr/local/opt/icu4c/bin:$PATH"
# export PATH="/usr/local/opt/icu4c/sbin:$PATH"
# export PATH="/usr/local/opt/texinfo/bin:$PATH"


export EVENT_NOKQUEUE=1


# eval "$(rbenv init - zsh)"


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
# alias pip=/usr/local/bin/pip3
# alias python3=/usr/local/bin/python3
# if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
#     source ~/.gnupg/.gpg-agent-info
#     export GPG_AGENT_INFO
# else
#     eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
# fi

# eval "$(uv generate-shell-completion zsh)"
# eval "$(uvx --generate-shell-completion zsh)"

alias nvimInstall='make distclean && make deps && make && make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=$HOME/bin/nvim install'
# Some aliases for Homebrew
alias bup='brew update && brew upgrade'
alias bout='brew outdated'
alias bin='brew install'
alias brm='brew uninstall'
alias bls='brew list'
alias bsr='brew search'
alias binf='brew info'
alias bdr='brew doctor'

# Some directory listing with colors
alias sl=ls
# alias ls='ls -GpF'        # Compact view, show colors
alias la='ls -GAF'       # Compact view, show hidden
alias ll='ls -alGpF'
alias l='ls -a'
alias l1='ls -1'

# because I'm to lazy to write vim
alias v='nvim'
# alias n="nvim"
alias s="sudo"
# Desktop Programs
alias f='open -a Finder '
alias fh='open -a Finder .'

# Usefull stuff for presentation and seeing dotfiles
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias showall='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
alias hideall='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'

# Get rid of those pesky .DS_Store files recursively
alias dsclean='find . -type f -name .DS_Store -print0 | xargs -0 rm'
# Flush your dns cache
alias flush='dscacheutil -flushcache'
alias luamake=/Users/mhartington/Github/lua-language-server/3rd/luamake/luamake

function symLink(){
echo "Creating symlinks"
cp -f dist/js/ionic.bundle.js tmp/www/lib/ionic/js/ionic.bundle.js
cp -f dist/css/ionic.css tmp/www/lib/ionic/css/ionic.css
echo "done"
  }

  # Because Typing python -m SimpleHTTPServer is too Damn Long
  # Start an HTTP server from a directory, optionally specifying the port
function server() {
  local port="${1:-8000}"
  #    open "http://localhost:${port}/"
  open -a google\ chrome\ canary "http://localhost:${port}/" --args --disable-web-security
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

function download(){
curl -O "$1"
}

# function highlight(){
#   highlight -O rtf $1 --font-size 25 --style solarized-dark -W -J 50 -j 3 --src-lang $2 | pbcopy
#
# }
function hl() {
pbpaste | npx prettier --parser $1 | highlight --font "GeistMono Nerd Font Mono" --font-size "44" --style "base16/oceanicnext" --syntax "$1" --out-format "rtf" | pbcopy
}


function hlRaw() {
pbpaste | highlight --font "GeistMono Nerd Font Mono" --font-size "44" --style "base16/oceanicnext" --syntax "$1" --out-format "rtf" | pbcopy
}

alias dl=download

function ghUpdate() {
  if git remote | grep upstream > /dev/null; then
    echo "upstream is set"
  elif [ -z "$1" ]; then
    read "?Whats the URl of the original repo? " answer
    git remote add upstream $answer
  else
    git remote add upstream $1
  fi
  git fetch upstream
  git checkout master
  git rebase upstream/master
}

function ghPages(){
  if [ -z "$1" ]
  then
    read "?Which folder do you want to deploy to GitHub Pages? " answer
    git subtree push --prefix $answer origin gh-pages
  else
    git subtree push --prefix $1 origin gh-pages
  fi
}

function deployHugo(){
  if [ -z "$1" ]
  then
    read "?Which folder do you want to deploy to GitHub Pages? " answer
    git subtree push --prefix $answer origin master
  else
    git subtree push --prefix $1 origin master
  fi
}


# incase i forget how to clear
alias c='clear'
alias k='clear'
alias cls='clear'

# archive file or folder
function compress()  {
    dirPriorToExe=`pwd`
    dirName=`dirname $1`
    baseName=`basename $1`

    if [ -f $1 ] ; then
      echo "It was a file change directory to $dirName"
      cd $dirName
      case $2 in
        tar.bz2)
          tar cjf $baseName.tar.bz2 $baseName
          ;;
        tar.gz)
          tar czf $baseName.tar.gz $baseName
          ;;
        gz)
          gzip $baseName
          ;;
        tar)
          tar -cvvf $baseName.tar $baseName
          ;;
        zip)
          zip -r $baseName.zip $baseName
          ;;
        *)
          echo "Method not passed compressing using tar.bz2"
          tar cjf $baseName.tar.bz2 $baseName
          ;;
      esac
      echo "Back to Directory $dirPriorToExe"
      cd $dirPriorToExe
    else
      if [ -d $1 ] ; then
        echo "It was a Directory change directory to $dirName"
        cd $dirName
        case $2 in
          tar.bz2)
            tar cjf $baseName.tar.bz2 $baseName
            ;;
          tar.gz)
            tar czf $baseName.tar.gz $baseName
            ;;
          gz)
            gzip -r $baseName
            ;;
          tar)
            tar -cvvf $baseName.tar $baseName
            ;;
          zip)
            zip -r $baseName.zip $baseName
            ;;
          *)
            echo "Method not passed compressing using tar.bz2"
            tar cjf $baseName.tar.bz2 $baseName
            ;;
        esac
        echo "Back to Directory $dirPriorToExe"
        cd $dirPriorToExe
      else
        echo "'$1' is not a valid file/folder"
      fi
    fi
    echo "Done"
    echo "###########################################"
  }

  # Extract archives - use: extract <file>
  # Based on http://dotfiles.org/~pseup/.bashrc
function extract() {
  local remove_archive
  local success
  local file_name
  local extract_dir

  if (( $# == 0 )); then
    echo "Usage: extract [-option] [file ...]"
    echo
    echo Options:
    echo "    -r, --remove    Remove archive."
  fi

  remove_archive=1
  if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
    remove_archive=0
    shift
  fi

  while (( $# > 0 )); do
    if [[ ! -f "$1" ]]; then
      echo "extract: '$1' is not a valid file" 1>&2
      shift
      continue
    fi

    success=0
    file_name="$( basename "$1" )"
    extract_dir="$( echo "$file_name" | sed "s/\.${1##*.}//g" )"
    case "$1" in
      (*.tar.gz|*.tgz) [ -z $commands[pigz] ] && tar zxvf "$1" || pigz -dc "$1" | tar xv ;;
      (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
      (*.tar.xz|*.txz) tar --xz --help &> /dev/null \
        && tar --xz -xvf "$1" \
        || xzcat "$1" | tar xvf - ;;
    (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null \
      && tar --lzma -xvf "$1" \
      || lzcat "$1" | tar xvf - ;;
  (*.tar) tar xvf "$1" ;;
  (*.gz) [ -z $commands[pigz] ] && gunzip "$1" || pigz -d "$1" ;;
  (*.bz2) bunzip2 "$1" ;;
  (*.xz) unxz "$1" ;;
  (*.lzma) unlzma "$1" ;;
  (*.Z) uncompress "$1" ;;
  (*.zip|*.war|*.jar|*.sublime-package) unzip "$1" -d $extract_dir ;;
  (*.rar) unrar x -ad "$1" ;;
  (*.7z) 7za x "$1" ;;
  (*.deb)
    mkdir -p "$extract_dir/control"
    mkdir -p "$extract_dir/data"
    cd "$extract_dir"; ar vx "../${1}" > /dev/null
    cd control; tar xzvf ../control.tar.gz
    cd ../data; tar xzvf ../data.tar.gz
    cd ..; rm *.tar.gz debian-binary
    cd ..
    ;;
  (*)
    echo "extract: '$1' cannot be extracted" 1>&2
    success=1
    ;;
esac

(( success = $success > 0 ? $success : $? ))
(( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
shift
  done
}
alias x=extract

function gif(){
   ffmpeg -i $1 -vf scale=$2:-1:flags=lanczos -f gif - | gifsicle --optimize=3 --delay=3 > $3
}
function fixAudio(){
  sudo kill -9 `ps ax|grep 'coreaudio[a-z]' | awk '{print $1}'`
}
function fixGpg(){
  gpgconf --kill gpg-agent
}

# function fixSSH(){
#   eval $(ssh-agent);
#   ssh-add ~/.ssh/id_rsa
# }

function ghPatch () {
  curl -L $1.patch | git am
}

# if [[ "$(uname -s)" == "Darwin" ]]; then
# fi

# killport() { lsof -i tcp:$1 | awk 'NR!=1 {print $2}' | xargs kill }

# function changeMac(){
#   local mac=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
#   sudo ifconfig en0 ether $mac
#   sudo ifconfig en0 down
#   sudo ifconfig en0 up
#   echo "Your new physical address is $mac"
# }
#
function cleanModules() {
  for i in $(find . -name node_modules -type d); do
    rm -r $i
  done
}
