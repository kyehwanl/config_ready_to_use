#!/bin/bash 

DRY_RUN=false

# Check for dry-run argument
for arg in "$@"; do
    case $arg in
        --dry-run)
            DRY_RUN=true
            ;;
    esac
done

# Function to execute or simulate a command
run_cmd() {
    if $DRY_RUN; then
        echo "[DRY-RUN] $@"
    else
        eval "$@"
    fi
}

. /vagrant/env-istio.sh

#CURRENT_IP=$(ifconfig | grep 192.168.10 | awk '{print $2}')
IPADDR=$(hostname -I 2>/dev/null | awk '{print $2}')
IP_CLUSTERMESH_APISERVER1="$(kubectl --context ${CLUSTER5_CTX} get svc -n kube-system -o jsonpath='{.items[0].status.loadBalancer.ingress[0].ip}')"
IP_CLUSTERMESH_APISERVER2="$(kubectl --context ${CLUSTER6_CTX} get svc -n kube-system -o jsonpath='{.items[0].status.loadBalancer.ingress[0].ip}')"

CLUSTER_SERVER1="$(kubectl config view -o jsonpath='{.clusters[0].cluster.server}' | awk -F[:/] '{print $4}')"
CLUSTER_SERVER2="$(kubectl config view -o jsonpath='{.clusters[1].cluster.server}' | awk -F[:/] '{print $4}')"

CLU_NAME1="$(kubectl config view -o jsonpath='{.clusters[0].name}')"
CLU_NAME2="$(kubectl config view -o jsonpath='{.clusters[1].name}')"

DEST=$HOST2
FORWARD_APISERVER=$IP_CLUSTERMESH_APISERVER2
IPTABLE_APISERVER=

if [[ "${IPADDR}" == "${CLUSTER_SERVER1}" ]] ; then
  FORWARD_APISERVER=$IP_CLUSTERMESH_APISERVER1
  IPTABLE_APISERVER=$IP_CLUSTERMESH_APISERVER2
  DEST=$CLUSTER_SERVER2

else
  FORWARD_APISERVER=$IP_CLUSTERMESH_APISERVER2
  IPTABLE_APISERVER=$IP_CLUSTERMESH_APISERVER1
  DEST=$CLUSTER_SERVER1
fi

run_cmd iptables -A INPUT -p tcp --dport 2379 -j ACCEPT
run_cmd iptables -A FORWARD -p tcp -d ${FORWARD_APISERVER} --dport 2379 -j ACCEPT
run_cmd ip route add ${IPTABLE_APISERVER} via ${DEST} 


echo iptables -A INPUT -p tcp --dport 2379 -j ACCEPT
echo iptables -A FORWARD -p tcp -d ${FORWARD_APISERVER} --dport 2379 -j ACCEPT
echo ip route add ${IPTABLE_APISERVER} via ${DEST} 

#iptables -A INPUT -p tcp --dport 2379 -j ACCEPT                     
#iptables -A FORWARD -p tcp -d 192.168.100.151 --dport 2379 -j ACCEPT
#ip route add 192.168.100.161 via 192.168.10.72                      



