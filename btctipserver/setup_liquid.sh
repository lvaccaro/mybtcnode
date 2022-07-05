#!/bin/bash

DESCRIPTOR=""
MASTER_BLINDING_KEY=""
DOMAIN=""
PORT=8082

# setup nginx
cat >> /etc/nginx/sites-available/btctipd_liquid << EOF
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
HiddenServiceDir /usr/local/var/lib/tor/btctip-liquid
HiddenServicePort 80 127.0.0.1:$PORT
EOF
systemctl restart tord

# setup systemd service
sed -e '/DESCRIPTOR/$DESCRIPTOR/' btctipd_liquid.service
sed -e '/PORT/$PORT/' btctipd_liquid.service
sed -e '/MASTER_BLINDING_KEY/$MASTER_BLINDING_KEY/' btctipd_liquid.service
cp btctipd_liquid.service /etc/systemd/system/

# start systemd service
mkdir -p ~/.btctipserver
systemctl daemon-reload
systemctl start btctipd_liquid
systemctl status btctipd_liquid
systemctl enable btctipd_liquid


