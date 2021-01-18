# Obligatory Dotfile Repo

Nothing super crazy going on here, but some sensable vim and tmux configs.

## Note to iterm
Iterm nightly is a must.
Or any terminal that supports true colors.

Once installed, click on the iterm color config in `config/colors` to add oceanicNext

## NeoVim

I've moved over to neovim completely. It still has it's problems here and there, but its pretty stable for the most part.

Anyways, neovim has support for true colors, so that flag is turned on.
Some key plugins for neovim are:


### Vim-Airline
[vim-airline](https://github.com/vim-airline/vim-airline) is much lighterweight, intergrates with a bunch of plugins I
already have, and is eaiser to set up.

```
call dein#add('vim-airline/vim-airline')
```

### Anything by Shougo
The guy is big in the vim/neovim community and his plugins are top notch.
Hell, even my plugin manager is made by him. If he ever sees this, thanks Shougo!

### [Quramy/tsuquyomi](https://github.com/Quramy/tsuquyomi)
Code completion for typescript. This is a must for me.

```bash
# install typescript
npm -g install typescript
```


```viml
call dein#add('Shougo/deoplete')
call dein#add('mhartington/deoplete-typescript')
```

It may take a bit on first startup or with a large project, but that's typescript's fault...not mine.

### [ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons)

This is really optional and over the top, but it adds icons to your file tree (if using nerdTree). So over the top....I need it.

I use Source Code Pro for my fonts, maybe you do too. But we're using powerline here folks, so we need some patched fonts.

https://github.com/ryanoasis/nerd-fonts

Install one of these fonts and you should be good to go. Don't forget to set your terminal font to that font as well.

## Tmux

So if you can tell by now, I'm set on using true colors....everywhere.

You can run `brew install tmux --head` and get all the colors for iterm nightly.

### Tmux powerline
My status bar for tmux is custom, only using a few plugins for battery charge and memory usage. Was a nice experiment with the tmux API. Also it uses powerline symbols, which should be covered.


<hr/>
I think that's it, probably missed a few things here and there or spelled something wrong.
This is more for my own sake when setting up a new machine so I can figure out what the fuck is actually going on.


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
## Inspiration
- [Maximum Awesome](https://github.com/square/maximum-awesome)
- [Paul's Dotfiles](https://github.com/paulirish/dotfiles)
- [Andrew's Dotfiles](https://github.com/ajoslin/dot)
