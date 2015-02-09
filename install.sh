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
"macvim --override-system-vim"
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
cp ~/.vimrc ~/.vimrc.bak
echo "Old vimrc is now saved as vimrc.bak"
cp ~/.tmux.conf ~/.tmux.conf.bak
echo "Old tmux.conf is now saved as tmux.conf.bak"
cp ~/.zshrc ~/.zshrc.back
echo "Old zshrc is now saved as zshrc.bak"
echo "---------------------------------------------------------"

echo "installing the powerline-fonts"
git clone https://github.com/powerline/fonts.git ~/.fonts
cd ~/.fonts
./install.sh


# Okay so everything should be good
# Fingers cross at least
# Now lets clone my dotfiles repo into .dotfiles/
echo "---------------------------------------------------------"

echo "Cloning Mike's dotfiles insto .dotfiles"
git clone https://github.com/mhartington/dotfiles.git ~/.dotfiles
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


echo "All done!"
echo "Now your part, change iterms settings to use xterm256color"
echo "and change your terminal font to one of the powerline fonts"
echo "Cheers"
-echo "---------------------------------------------------------"

exit 0
