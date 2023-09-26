#! /bin/bash
apt-get install -y git policykit-1
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
cp /tmp/reddit.service /etc/systemd/system/reddit.service
systemctl enable reddit.service
