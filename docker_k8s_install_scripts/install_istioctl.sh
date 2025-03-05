#!/bin/sh
set -x

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.24.3 sh -
cd istio-1.24.3
sudo install -m 0755 bin/istioctl /usr/local/bin/istioctl



