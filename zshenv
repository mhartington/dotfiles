export KEYTIMEOUT=1
export TERMINAL_DARK=1
export TERM=xterm-256color-italic
export CLICOLOR=1
export EDITOR=nvim
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
export PATH=${PATH}:~/.cargo/bin:$PATH
export ANDROID_HOME=~/Library/Android/sdk
export BREW_PATH=$(brew --prefix)
export GRADLE_HOME=$BREW_PATH
export PATH=$PATH:$GRADLE_HOME/bin
export RUST_SRC_PATH=$HOME/.cargo/bin
export PATH=$PATH:$RUST_SRC_PATH
export PATH=$PATH:$GOPATH/bin
PATH=$PATH:$HOME/.composer/vendor/bin
export NPM_TOKEN=19e676c0-ed55-4f5c-94ec-05ee8a55ece1
export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export ZLE_RPROMPT_INDENT=0
export BULLETTRAIN_TIME_SHOW=false
export BULLETTRAIN_STATUS_SHOW=false
export BULLETTRAIN_PROMPT_ADD_NEWLINE=false
export DISABLE_AUTO_TITLE=true
export EVENT_NOKQUEUE=1
export VSCODE_TSJS=1

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
alias ls='ls -G'        # Compact view, show colors
alias la='ls -AF'       # Compact view, show hidden
alias ll='ls -al'
alias l='ls -a'
alias l1='ls -1'

# because I'm to lazy to write vim
alias v='nvim'
# alias n="nvim"
alias s="sudo"
# alias n="open -a /Applications/Neovim.app"
# Desktop Programs
alias xcode="open -a '/Applications/XCode.app'"
alias safari="open -a safari"
alias chrome="open -a google\ chrome"
alias chromium="open -a chromium"
alias f='open -a Finder '
alias fh='open -a Finder .'
alias textedit='open -a TextEdit'
alias hex='open -a "Hex Fiend"'
alias skype='open -a Skype'
alias slack="open -a '/Applications/Slack.app'"

# Usefull stuff for presentation and seeing dotfiles
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias showall='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
alias hideall='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'

# Get rid of those pesky .DS_Store files recursively
alias dsclean='find . -type f -name .DS_Store -print0 | xargs -0 rm'

# Flush your dns cache
alias flush='dscacheutil -flushcache'

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

function run(){
ionic build "$1" && ionic run "$1" --device -lc
}
function sim(){
ionic build "$1" && ionic emulate "$1"
}

function download(){
curl -O "$1"
}

function highlight(){
  highlight -O rtf $1 --font-size 25 --style solarized-dark -W -J 50 -j 3 --src-lang $2 | pbcopy
}

alias dl=download
function ghUpdate() {
if git remote | grep upstream > /dev/null;
then
  echo "upstream is set"
else
  read "?Whats the URl of the original repo? | " answer
  # Add the remote, call it "upstream":
  echo $answer
  git remote add upstream $answer

fi
git fetch upstream
git checkout master
git rebase upstream/master
  }

function ghPages(){
  if [ -z "$1" ]
  then
    echo "Which folder do you want to deploy to GitHub Pages?"
    exit 1
  fi
  git subtree push --prefix $1 origin gh-pages

}

# incase i forget how to clear
  alias c='clear'
  alias k='clear'
  alias cls='clear'

# presentation crap
  # alias whoamireally='echo "Mike Hartington
  # Dev Advocate for Ionic
  # Beer lover and Cat lover" '

# archive file or folder
  function compress()
  {
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

function fixSSH(){
  eval $(ssh-agent);
  ssh-add ~/.ssh/id_rsa
}

function ghPatch () {
  curl -L $1.patch | git am
}
