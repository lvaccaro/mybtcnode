#!/bin/bash

# setup onion endpoint
mkdir /home/satoshi/.lightning
cp lightning.config /home/satoshi/.lightning/config
ENDPOINT=$(cat /usr/local/var/lib/tor/lightningd/hostname)
echo "announce-addr=$ENDPOINT" >> /home/satoshi/.lightning/config

# use bcli esplora script instead bitcoin-cli
cp bcli-esplora.sh /home/satoshi/
chmod +x /home/satoshi/bcli-esplora.sh

# setup clnurl plugin
git clone https://github.com/elsirion/clnurl
cd clnurl
cargo build -r
cd ..

# setup commando plugin
git checkout https://github.com/lightningd/plugins.git
cd plugins
python3 -m virtualenv venv
source venv/bin/activate
pip install -r requirements.txt

# setup c-lightning Hidden Service
cat >> /etc/tor/torrc << EOF
HiddenServiceDir /usr/local/var/lib/tor/lightningd
HiddenServiceVersion 3
HiddenServicePort 1234 127.0.0.1:9735
EOF
systemctl restart tord
sleep 10

# setup systemd service
cp lightningd.service /etc/systemd/system
systemctl daemon-reload
systemctl start lightningd
systemctl status lightningd
systemctl enable lightningd

# test example command
runuser -l satoshi -c '/usr/bin/lightningd-cli getblockchaininfo'

# test commando plugin command
nodehost=$(lightning-cli getinfo | jq -r '. as $r | .address[0] | "\($r.id)@\(.address):\(.port)"')
token=$(lightning-cli commando-rune restrictions=readonly | jq -r '.rune | @uri')
echo "lnlink:$nodehost?token=$token"

# run example 
/usr/local/bin/lightningd --network bitcoin --log-level debug \
 --bitcoin-cli /opt/bcli-esplora.sh \
 --plugin=/opt/plugins/commando/commando.py \
 --plugin=/opt/clnurl/target/release/clnurl \
 --clnurl_base_address=https://lvaccaro.com/lnurl_api

