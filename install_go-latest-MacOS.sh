#!/bin/bash -x

ARCH="arm64"
OS="darwin"

GO_URL="https://go.dev/dl/"
LATEST_VERSION=$(curl -sL "$GO_URL" | grep -oE "go[0-9]+\.[0-9]+(\.[0-9]+)?\.$OS-$ARCH\.tar\.gz" | head -n 1)

if [ -z "$LATEST_VERSION" ]; then
  echo "❌  Cannot find the latest Go version."
  exit 1
fi

curl -LO "https://go.dev/dl/$LATEST_VERSION"

sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "$LATEST_VERSION"

if ! grep -q "/usr/local/go/bin" ~/.bash_profile; then
  echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bash_profile
fi

export PATH=$PATH:/usr/local/go/bin
go version

rm "$LATEST_VERSION"
