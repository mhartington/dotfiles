#!/bin/sh

brew="/usr/local/bin/brew"
if [ -f "$brew" ]
then
  echo "Homebrew is installed, nothing to do here"
else
  echo "Homebrew is not installed, installing now"
  echo "This may take a while"
  echo "Homebrew requires osx command lines tools, please download xcode first"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

fi

packages=(
"git"
"node"
"tmux"
"lua"
"neovim"
"weechat --with-lua --with-perl --with-python --with-ruby"
)

for i in "${packages[@]}"
do
  brew install $i
  echo "---------------------------------------------------------"
done

echo "installing RCM, for dotfiles management"
brew tap thoughtbot/formulae
brew install rcm
echo "---------------------------------------------------------"

localGit="/usr/local/bin/git"
if [ -f "$localGit" ]
then
  echo "git is all good"
else
  echo "git is not installed"
fi
echo "---------------------------------------------------------"


echo "Making backups of vim, tmux conf files"
if [ -e ~/.vimrc ]
then
  cp ~/.vimrc ~/.vimrc.bak
  echo "Old vimrc is now saved as vimrc.bak"
fi

if [ -e ~/.tmux.conf ]
then
  cp ~/.tmux.conf ~/.tmux.conf.bak
  echo "Old tmux.conf is now saved as tmux.conf.bak"
fi

if [ -e ~/.zshrc ]
then
  cp ~/.zshrc ~/.zshrc.back
  echo "Old zshrc is now saved as zshrc.bak"
fi
echo "---------------------------------------------------------"

# Okay so everything should be good
# Fingers cross at least
# Now lets clone my dotfiles repo into .dotfiles/
echo "---------------------------------------------------------"

echo "Cloning Mike's dotfiles insto .dotfiles"
git clone https://github.com/mhartington/dotfiles.git ~/.dotfiles

cd .dotfiles
git submodule update --init --recursive

cd $HOME
echo "running RCM's rcup command"
echo "This is symlink the rc files in .dofiles"
echo "with the rc files in $HOME"
echo "---------------------------------------------------------"

rcup

echo "---------------------------------------------------------"

echo "Changing to zsh"
chsh -s $(which zsh)

echo "You'll need to log out for this to take effect"
echo "---------------------------------------------------------"

echo "running oxs defaults"
~./osx.sh

# echo "---------------------------------------------------------"
# echo "Installing H"
# rock=(
# "mjolnir.application"
# "mjolnir.fnutils"
# "mjolnir.geometry"
# "mjolnir.hotkey"
# "mjolnir.screen"
# "mjolnir.keycodes"
# )
# for r in "${rocks[@]}"
# do
#   luarocks install $r

echo "---------------------------------------------------------"
echo "All done!"
echo "and change your terminal font to source code pro"
echo "Cheers"
-echo "---------------------------------------------------------"

exit 0
