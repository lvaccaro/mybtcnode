#!/bin/bash

# setup lightningd service folder
mkdir -p /usr/local/var/lib/tor/lightningd
chown -R satoshi.satoshi /usr/local/var/lib/tor/lightningd
chmod a-rwx /usr/local/var/lib/tor/lightningd
chmod u+rwx /usr/local/var/lib/tor/lightningd

# setup systemd service
cp tord.service /etc/systemd/system
systemctl daemon-reload
systemctl enable tord
systemctl start tord
systemctl status tord

# lightning onion endpoint
cat /usr/local/var/lib/tor/lightningd/hostname