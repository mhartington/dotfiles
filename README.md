# Obligatory Dotfile Repo

Neovim, Kitty, Tmux...oh my.

## Install
Note this install is if you have a new machine, and need everything setup.
For that, I sugguest

```
curl https://cdn.rawgit.com/mhartington/dotfiles/master/install.sh | sh
```

If you already have things like git, homebrew,node etc installed, then here have a cookie and sit back.
You should just be able to just run these few lines.

```
brew tap thoughtbot/formulae
brew install rcm
git clone https://github.com/mhartington/dotfiles.git ~/.dotfiles
cd $HOME
rcup
```

