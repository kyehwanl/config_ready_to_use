#!/bin/bash -x

# install go 1.24.6 (as of 2025.08.07) - https://go.dev/doc/install

# 1. latest  Go version
GO_URL="https://go.dev/dl/"
LATEST_VERSION=$(curl -sL "$GO_URL" | grep -oP 'go[0-9]+\.[0-9]+(\.[0-9]+)?\.linux-amd64\.tar\.gz' | head -n 1)
if [ -z "$LATEST_VERSION" ]; then
  echo "❌  Cannot find the latest Go version."
  exit 1
fi

# 2. Download
wget "https://go.dev/dl/$LATEST_VERSION"

# 3. remove the previous and untar 
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "$LATEST_VERSION"

# 4. Env variable and check
echo "PATH=$PATH:/usr/local/go/bin" >> ${HOME}/.bashrc
export PATH=$PATH:/usr/local/go/bin
go version



