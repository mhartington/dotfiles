
#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####
#!/bin/sh

# This is for android crap
export PATH=${PATH}:~/Library/Android/sdk/platform-tools:~/Library/Android/sdk/tools
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=${JAVA_HOME}/bin:$PATH
export PATH=/usr/local/bin:$PATH



export _Z_DATA="$HOME/z-data"


source ~/.z/z.sh

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NO_COLOUR="\[\033[0m\]"

function _git_prompt() {
local git_status="`git status -unormal 2>&1`"
# Checks to see if we're in a git repo
if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
  # if we're in a repo thats clean, then color it green
  if [[ "$git_status" =~ nothing\ to\ commit ]]; then
    local ansi=$GREEN
    # if the repos dirty, color it red
  elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
    local ansi=$RED
  else
    #Just to be sure, color it red
    local ansi=$RED
  fi

  # Get git branch name
  # checks the output of git status for "On branch " then uses that to set the branch
  if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
    branch=${BASH_REMATCH[1]}
    #test "$branch" != master || branch=' '
  else
    # Detached HEAD.  (branch=HEAD is a faster alternative.)
    branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
      echo HEAD`)"
  fi
  # prints out " | $branch_name"
  echo -n '| \['"$ansi"'\]'"$branch"'\[\e[0m\] [$(_git_changes)]'
fi
}

function _git_changes {
[[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == true ]] || return 1

local added_symbol="●"
local unmerged_symbol="✗"
local modified_symbol="+"
local clean_symbol="✔"
local has_untracked_files_symbol="…"

local ahead_symbol="↑"
local behind_symbol="↓"

local unmerged_count=0 modified_count=0 has_untracked_files=0 added_count=0 is_clean=""

set -- $(git rev-list --left-right --count @{upstream}...HEAD 2>/dev/null)
local behind_count=$1
local ahead_count=$2

# Added (A), Copied (C), Deleted (D), Modified (M), Renamed (R), changed (T), Unmerged (U), Unknown (X), Broken (B)
while read line; do
  case "$line" in
    M*) modified_count=$(( $modified_count + 1 )) ;;
    U*) unmerged_count=$(( $unmerged_count + 1 )) ;;
  esac
done < <(git diff --name-status)

while read line; do
  case "$line" in
    *) added_count=$(( $added_count + 1 )) ;;
  esac
done < <(git diff --name-status --cached)

if [ -n "$(git ls-files --others --exclude-standard)" ]; then
  has_untracked_files=1
fi

if [ $(( unmerged_count + modified_count + has_untracked_files + added_count )) -eq 0 ]; then
  is_clean=1
fi

local leading_whitespace=""
[[ $ahead_count -gt 0 ]]         && { printf "%s" "$leading_whitespace$ahead_symbol$ahead_count"; leading_whitespace=" "; }
[[ $behind_count -gt 0 ]]        && { printf "%s" "$leading_whitespace$behind_symbol$behind_count"; leading_whitespace=" "; }
[[ $modified_count -gt 0 ]]      && { printf "%s" "$leading_whitespace$modified_symbol$modified_count"; leading_whitespace=" "; }
[[ $unmerged_count -gt 0 ]]      && { printf "%s" "$leading_whitespace$unmerged_symbol$unmerged_count"; leading_whitespace=" "; }
[[ $added_count -gt 0 ]]         && { printf "%s" "$leading_whitespace$added_symbol$added_count"; leading_whitespace=" "; }
[[ $has_untracked_files -gt 0 ]] && { printf "%s" "$leading_whitespace$has_untracked_files_symbol"; leading_whitespace=" "; }
[[ $is_clean -gt 0 ]]            && { printf "%s" "$leading_whitespace$clean_symbol"; leading_whitespace=" "; }
}


export _PS1="$YELLOW\u$NO_COLOUR:\w$(_git_prompt)"
export PROMPT_COMMAND='export PS1="${_PS1} $(_git_prompt)\n$ "'



#aliases and functions
# Some directory listing with colors
alias sl=ls
alias ls='ls -G'        # Compact view, show colors
alias la='ls -AF'       # Compact view, show hidden
alias ll='ls -al'
alias l='ls -a'
alias l1='ls -1'

# Usefull stuff for presentation and seeing dotfiles
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias showall='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
alias hideall='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'

# Get rid of those pesky .DS_Store files recursively
alias dsclean='find . -type f -name .DS_Store -print0 | xargs -0 rm'

# Flush your dns cache
alias flush='dscacheutil -flushcache'


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


alias dl=download


# incase i forget how to clear
alias c='clear'
alias k='clear'
alias cls='clear'


# archive file or folder
function compress() {
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

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash


[ -s "/Users/mhartington/.jabba/jabba.sh" ] && source "/Users/mhartington/.jabba/jabba.sh"

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####
