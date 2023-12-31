#!/bin/bash
set -e
APP_DIR=${1:-$HOME}
sudo apt-get update -y
sleep 80
sudo apt-get install -y git policykit-1
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
