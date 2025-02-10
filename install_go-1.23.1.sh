#!/bin/bash -x

# install go 1.23.1 (as of 2024.09.19) - https://go.dev/doc/install
wget https://go.dev/dl/go1.23.1.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.23.1.linux-amd64.tar.gz
echo "PATH=$PATH:/usr/local/go/bin" >> ${HOME}/.bashrc
export PATH=$PATH:/usr/local/go/bin
go version



