#!/bin/sh
set -x
helm repo add metallb https://metallb.github.io/metallb
helm repo update
helm upgrade --install metallb  metallb/metallb --create-namespace --namespace metallb-system

sleep 1

cat <<EOF > IPAddressPool.yaml
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default-pool
  namespace: metallb-system
spec:
  addresses:
  - 192.168.1.10-192.168.1.20
EOF
kubectl apply -f IPAddressPool.yaml


cat <<EOF > L2Advertisement.yaml
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: default
  namespace: metallb-system
spec:
  ipAddressPools:
  - default-pool
EOF

kubectl apply -f L2Advertisement.yaml

