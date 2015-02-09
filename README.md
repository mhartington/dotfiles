#Obligatory Dotfile Repo
###
Nothing super crazy going on here, but some sensable vim and tmux configs.

##Note to iterm
I use solarized for my color scheme, but iterm is wonky with it.
Rule of thumb is to set your terminal emulation to `xterm-256`

I believe OSX's terminal app should be okay, but will make note of that.

##Powerline
I used to use python-powerline, but have switch to using a combination of vim-airline, vim-promptline, and a custum
tmux.conf for similar results. 

### Vim-Airline
 [vim-airline](https://github.com/bling/vim-airline) is much lighterweight, intergrates with a bunch of plugins I
already have, and is eaiser to set up.

```
  Bundle 'bling/vim-airline'
```
Then adding these [two lines](https://github.com/mhartington/dotfiles/blob/master/vimrc#L157) is all you need to do.

### Vim-promptline
[vim-promptline](https://github.com/edkolev/promptline.vim) is a vim plugin to generate a shell theme for bash or zsh.
It's fairly simple and straight forward. In fact all you need to really add [is listed
here](https://github.com/mhartington/dotfiles/blob/master/vimrc#L161).

### Tmux powerline
For speed reasons, I've removed any plugins and used available features in tmux. The
[status-bar](https://github.com/mhartington/dotfiles/blob/master/tmux.conf#L77) is setup for solarized, and includes ad
indicator for when the bind-key is pressed.

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
##Inspiration
 - [Maximum Awesome](https://github.com/square/maximum-awesome)
 - [Paul's Dotfiles](https://github.com/paulirish/dotfiles)
 - [Andrew's Dotfiles](https://github.com/ajoslin/dot)
