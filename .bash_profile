# Startup file for bash login shells.
#
default_dir=/usr/local/lib/bash

if [ "$PS1" ]; then
  ignoreeof=3
fi

LOGIN_SHELL=true
# If the user has her own init file, then use that one, else use the
# canonical one.
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
else if [ -f ${default_dir}Bashrc ]; then
  source ${default_dir}Bashrc;
  fi
fi

if [ -f ~/.bash_login ]; then
	source ~/.bash_login
fi
export SVN_EDITOR=vi

function psgrep ()
{
ps aux | grep "$1" | grep -v 'grep'
}
function psterm ()
{
[ ${#} -eq 0 ] && echo "usage: $FUNCNAME STRING" && return 0
local pid
pid=$(ps ax | grep "$1" | grep -v grep | awk '{ print $1 }')
echo -e "terminating '$1' / process(es):\n$pid"
kill -SIGTERM $pid
}
