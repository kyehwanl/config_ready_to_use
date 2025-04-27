#!/bin/bash

LOC="/vagrant/istio-multicluster-script/9-istio/"
. /vagrant/env-istio.sh

# download istio images to a host
echo "Pulling istio images to a docker host..."
docker pull $HUB/pilot:$TAG
docker pull $HUB/proxyv2:$TAG



# install certs in both clusters
kubectl create namespace istio-system --context=${CLUSTER5_CTX}
kubectl create secret generic cacerts -n istio-system \
      --from-file=${LOC}certs/cluster1/ca-cert.pem \
      --from-file=${LOC}certs/cluster1/ca-key.pem \
      --from-file=${LOC}certs/cluster1/root-cert.pem \
      --from-file=${LOC}certs/cluster1/cert-chain.pem \
      --context=${CLUSTER5_CTX}

kubectl create namespace istio-system --context=${CLUSTER6_CTX}
kubectl create secret generic cacerts -n istio-system \
      --from-file=${LOC}certs/cluster2/ca-cert.pem \
      --from-file=${LOC}certs/cluster2/ca-key.pem \
      --from-file=${LOC}certs/cluster2/root-cert.pem \
      --from-file=${LOC}certs/cluster2/cert-chain.pem \
      --context=${CLUSTER6_CTX}

# Install istio iop profile on cluster5
echo "Installing istio in $CLUSTER5_NAME..."
istioctl --context="${CLUSTER5_CTX}" install -f ${LOC}iop-clu1.yaml --skip-confirmation

# Install istio profile on cluster6
echo "Installing istio in $CLUSTER6_NAME..."
istioctl --context="${CLUSTER6_CTX}" install -f ${LOC}iop-clu2.yaml --skip-confirmation

## fetch cluster2 controlplan address
#SERVER_CLU2=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' clu2-control-plane)

# Enable Endpoint Discovery
echo "Enable Endpoint Discovery..."
istioctl create-remote-secret \
    --context="${CLUSTER6_CTX}" \
    --name=cluster2 | \
    kubectl apply -f - --context="${CLUSTER5_CTX}"

istioctl create-remote-secret \
    --context="${CLUSTER5_CTX}" \
    --name=cluter1 | \
    kubectl apply -f - --context="${CLUSTER6_CTX}"
