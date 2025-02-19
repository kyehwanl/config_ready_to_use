#!/bin/sh
set -x

wget https://github.com/hidetatz/kubecolor/releases/download/v0.0.25/kubecolor_0.0.25_Linux_x86_64.tar.gz
tar zxvf kubecolor_0.0.25_Linux_x86_64.tar.gz kubecolor
sudo cp -rf kubecolor /usr/bin/

command -v kubecolor >/dev/null 2>&1 && echo 'alias kubectl="kubecolor"' >> ~/.bash_aliases 

