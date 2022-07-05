#!/bin/bash

DESCRIPTOR=""
DOMAIN=""
PORT=8081

# setup nginx
cat >> /etc/nginx/sites-available/btctipd_testnet << EOF
server {
    server_name $DOMAIN;

    location / {
       proxy_pass http://127.0.0.1:$PORT;
    }
}
EOF
systemctl reload nginx

# setup btctipserver bitcoin Hidden Service
cat >> /etc/tor/torrc << EOF
HiddenServiceDir /usr/local/var/lib/tor/btctip-testnet
HiddenServicePort 80 127.0.0.1:$PORT
EOF
systemctl restart tord

# setup systemd service
sed -e '/DESCRIPTOR/$DESCRIPTOR/' btctipd_testnet.service
sed -e '/PORT/$PORT/' btctipd_testnet.service
cp btctipd_testnet.service /etc/systemd/system/

# start systemd service
mkdir -p ~/.btctipserver
systemctl daemon-reload
systemctl start btctipd_testnet
systemctl status btctipd_testnet
systemctl enable btctipd_testnet


