if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
export PATH=$PATH:~/.nexustools

export PATH="$HOME/.cargo/bin:$PATH"

[ -s "/Users/mhartington/.jabba/jabba.sh" ] && source "/Users/mhartington/.jabba/jabba.sh"
