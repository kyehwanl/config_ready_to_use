#! /bin/bash
# Installing Open5Gs - 5G in a Box
apt-get -y update
apt-get install -y gnupg wget tcpdump 
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc > key.asc 
sudo apt-key add key.asc
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
apt-get -y update
apt install -y mongodb-org mongodb-clients
sudo systemctl start mongod
sudo systemctl enable mongod
