#!/bin/bash -x

# from https://get.docker.com
command_exists() {
	command -v "$@" > /dev/null 2>&1
}

get_distribution() {
    lsb_dist=""
    # Every system that we officially support has /etc/os-release
    if [ -r /etc/os-release ]; then
        lsb_dist="$(. /etc/os-release && echo "$ID")"
    fi
    # Returning an empty string here should be alright since the
    # case statements don't act unless you provide an actual value
    echo "$lsb_dist"
}


    # perform some very rudimentary platform detection
    lsb_dist=$( get_distribution )
    lsb_dist="$(echo "$lsb_dist" | tr '[:upper:]' '[:lower:]')"

    case "$lsb_dist" in

        ubuntu)
            if command_exists lsb_release; then
                dist_version="$(lsb_release --codename | cut -f2)"
            fi
            if [ -z "$dist_version" ] && [ -r /etc/lsb-release ]; then
                dist_version="$(. /etc/lsb-release && echo "$DISTRIB_CODENAME")"
            fi
        ;;

        debian|raspbian)
            dist_version="$(sed 's/\/.*//' /etc/debian_version | sed 's/\..*//')"
            case "$dist_version" in
                11)
                    dist_version="bullseye"
                ;;
                10)
                    dist_version="buster"
                ;;
                9)
                    dist_version="stretch"
                ;;
                8)
                    dist_version="jessie"
                ;;
            esac
        ;;

        centos|rhel|sles)
            if [ -z "$dist_version" ] && [ -r /etc/os-release ]; then
                dist_version="$(. /etc/os-release && echo "$VERSION_ID")"
            fi
        ;;

        *)
            if command_exists lsb_release; then
                dist_version="$(lsb_release --release | cut -f2)"
            fi
            if [ -z "$dist_version" ] && [ -r /etc/os-release ]; then
                dist_version="$(. /etc/os-release && echo "$VERSION_ID")"
            fi
        ;;

    esac

if [ "$lsb_dist" == "centos" ] || [ "$lsb_dist" == "rhel" ]; then
  yum -y install epel-release 
  yum -y install tmux vim vifm ctags cscope gcc automake autoconf libtool net-tools psmisc patch wget
  yum -y install go
fi

if [ "$lsb_dist" == "ubuntu" ]; then
  sudo apt update
  command -v sudo >/dev/null 2>&1 || (apt update && apt install -y sudo) # in case docker container doesn't have sudo
  sudo apt install -y ctags
  sudo apt install -y exuberant-ctags
  sudo apt install -y make 
  sudo apt install -y gcc automake autoconf libtool
  sudo apt install -y tmux vim vifm cscope net-tools psmisc patch wget
fi

cd ~/
git clone https://github.com/kyehwanl/config_ready_to_use.git
unalias cp
cp -rf config_ready_to_use/.[a-z]* config_ready_to_use/* ./
rm -rf config_ready_to_use
find ./ -name '*.tar.gz' | xargs -I % tar xvfz % > /dev/null
export TERM=screen-256color


echo "--- ble.sh install ---"
git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
make -C ble.sh install PREFIX=~/.local
#echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc


echo "--- kubecolor install ---"
wget https://github.com/hidetatz/kubecolor/releases/download/v0.0.25/kubecolor_0.0.25_Linux_x86_64.tar.gz
tar zxvf kubecolor_0.0.25_Linux_x86_64.tar.gz kubecolor                                                  
sudo cp -rf kubecolor /usr/bin/


echo "--- Go install v1.23.3 ---"
wget https://go.dev/dl/go1.23.3.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.23.3.linux-amd64.tar.gz


echo "--- gotags install ---"
/usr/local/go/bin/go install github.com/jstemmer/gotags@latest


echo "--- Lazygit install ---"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin


echo "--- vim go settings ---"
git clone https://github.com/fatih/vim-go.git
#git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
rm -rf ~/.vim/bundle/vim-go && mv vim-go ~/.vim/bundle/
#vim +':GoInstallBinaries' +qall
#vim +'silent :GoInstallBinaries' +qall
/usr/local/go/bin/go install golang.org/x/tools/gopls@latest


echo "--- helm install ---"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
sudo [DESIRED_VERSION="v3.6.3"] ./get_helm.sh


echo "--- misc settings ---"
sudo timedatectl set-timezone America/New_York


#. ~/.bashrc
#. ~/.bash_aliases

echo "--- need to source ble.sh/out/ble.sh"
echo "--- need to source .bashrc and/or .bash_aliases"
echo "--- need to replace .kube/config with /etc/kubernetes/admin.conf if kubectl not working"

