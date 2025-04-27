#!/bin/sh
set -x

PWD=$(pwd)
#/vagrant/docker-ce-install-ubuntu.sh
/vagrant/install_KinD_latest.sh 
/vagrant/install_kubectl.sh
/vagrant/install_kubectl_completion.sh 
/vagrant/install_istioctl.sh 
/vagrant/install_cilium.sh 
/vagrant/install_k9s_webi.sh 


