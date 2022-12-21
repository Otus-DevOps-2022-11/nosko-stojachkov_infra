#!/bin/bash
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sleep 10
sudo apt-get update
sleep 10
sudo apt-get install -y mongodb-org
sleep 10
sudo systemctl start mongod
sleep 10
sudo systemctl enable mongod
sleep 10
sudo systemctl status mongod
