#!/usr/bin/env bash
sudo apt update
sudo apt-get install apt-transport-https ca-certificates
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get update
sudo apt-get install --reinstall dbus
sudo systemctl start dbus
sudo apt-get install -y mongodb-org
sleep 60
cat /lib/systemd/system/mongod.service
sleep 60
sudo systemctl start mongod
sudo systemctl enable mongod
sudo /usr/bin/mongod --config /etc/mongod.conf
