
#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
export PATH=$PATH:~/.nexustools

export PATH="$HOME/.cargo/bin:$PATH"

[ -s "/Users/mhartington/.jabba/jabba.sh" ] && source "/Users/mhartington/.jabba/jabba.sh"

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####
