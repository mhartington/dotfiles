#!/usr/bin/env bash

# libevent2 installation instructions from here
# https://gist.github.com/rschuman/6168833

sudo su -

yum -y install gcc kernel-devel make automake autoconf ncurses-devel
yum -y install git-core expect vim ruby ruby-devel ruby-irb

# install libevent2 from source
curl http://sourceforge.net/projects/levent/files/latest/download?source=files -L -o libevent2.tar.gz -w 'Last URL was: %{url_effective}'
cd ~/downloads
tar zxvf libevent2.tar.gz
cd ./libevent-*
./configure --prefix=/usr/local
make
make install

# compile tmux
git clone https://github.com/tmux/tmux.git ~/tmux_source
cd ~/tmux_source
git checkout 2.0
sh autogen.sh
LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
make && sudo make install
