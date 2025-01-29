#!/bin/sh

brew="/opt/homebrew/bin/brew"
if [ -f "$brew" ]
then
  echo "Homebrew is installed, nothing to do here"
else
  echo "Homebrew is not installed, installing now"
  echo "This may take a while"
  echo "Homebrew requires osx command lines tools, please download xcode first"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

localGit="/usr/local/bin/git"
if [ -f "$localGit" ]
then
  echo "git is all good"
else
  brew install git
fi
# Okay so everything should be good
# Fingers cross at least
# Now lets clone my dotfiles repo into .dotfiles/
echo "---------------------------------------------------------"
echo "Cloning Mike's dotfiles insto .dotfiles"
git clone https://github.com/mhartington/dotfiles.git ~/.dotfiles
cd .dotfiles
echo "Restoring homebrew from bundle file"
brew bundle -v
echo "---------------------------------------------------------"
cd $HOME
echo "running RCM's rcup command"
echo "This is symlink the rc files in .dofiles"
echo "with the rc files in $HOME"
rcup
echo "---------------------------------------------------------"

echo "---------------------------------------------------------"
echo "Changing to zsh"
chsh -s $(which zsh)

echo "You'll need to log out for this to take effect"
echo "---------------------------------------------------------"

echo "running oxs defaults"
~./osx.sh

echo "---------------------------------------------------------"
echo "All done!"
echo "and change your terminal font to source code pro"
echo "Cheers"
echo "---------------------------------------------------------"

exit 0
