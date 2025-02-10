#! /bin/bash -x

#cd $HOME

# download vim files
wget https://github.com/kyehwanl/config_ready_to_use/raw/master/.vimrc
wget https://github.com/kyehwanl/config_ready_to_use/raw/master/.gitconfig
wget https://github.com/kyehwanl/config_ready_to_use/raw/master/.bash_aliases
wget https://github.com/kyehwanl/config_ready_to_use/raw/master/.bashrc
wget https://github.com/kyehwanl/config_ready_to_use/raw/master/_.vim_2023_0203.tar.gz 
tar xvfz _.vim_2023_0203.tar.gz >/dev/null 2>&1 

cp -rf .vimrc .gitconfig .bash_aliases .bashrc $HOME/


# time zone change
apt update
command -v sudo >/dev/null 2>&1 || apt install -y sudo 
command -v timedatectl >/dev/null 2>&1 || sudo apt install -y systemd
command -v vim >/dev/null 2>&1 || apt install -y vim 
sudo timedatectl set-timezone America/New_York
sudo apt install ctags exuberant-ctags cscope -y


# ENV variables
alias pst="pstree -hupl | grep `echo $$`"
alias qq="exit"
echo 'alias pst="pstree -hupl | grep `echo $$`"' >> ~/.bashrc
echo 'alias qq="exit"' >> ~/.bashrc

source ~/.bashrc
