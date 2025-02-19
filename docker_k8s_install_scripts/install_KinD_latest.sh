#!/bin/sh
set -x

# install latest version of kind client 
curl -Lo ./kind "https://kind.sigs.k8s.io/dl/$(curl -s https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | grep -oP '"tag_name": "\K[^"]*')/kind-linux-amd64"
chmod +x kind
sudo mv kind /usr/local/bin/

