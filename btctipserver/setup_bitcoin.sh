#!/bin/bash

DESCRIPTOR=""
DOMAIN=""
PORT=8080

# setup nginx
cat >> /etc/nginx/sites-available/btctipd_bitcoin << EOF
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
HiddenServiceDir /usr/local/var/lib/tor/btctip-bitcoin
HiddenServicePort 80 127.0.0.1:$PORT
EOF
systemctl restart tord

# setup systemd service
sed -e '/DESCRIPTOR/$DESCRIPTOR/' btctipd_bitcoin.service
sed -e '/PORT/$PORT/' btctipd_bitcoin.service
cp btctipd_bitcoin.service /etc/systemd/system/

# start systemd service
mkdir -p ~/.btctipserver
systemctl daemon-reload
systemctl start btctipd_bitcoin
systemctl status btctipd_bitcoin
systemctl enable btctipd_bitcoin


