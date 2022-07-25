#!/bin/bash -x

yum -y install epel-release 
yum -y install tmux vim vifm ctags cscope gcc automake autoconf libtool net-tools psmisc patch wget
cd ~/
git clone https://github.com/kyehwanl/config_ready_to_use.git
unalias cp
cp -rf config_ready_to_use/.[a-z]* config_ready_to_use/* ./
rm -rf config_ready_to_use
find ./ -name '*.tar.gz' | xargs -I % tar xvfz % > /dev/null
source .bashrc
source .bash_aliases
export TERM=screen-256color


