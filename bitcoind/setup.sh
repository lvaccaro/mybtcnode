#!/bin/bash

# setup systemd service
cp bitcoind.service /etc/systemd/system
systemctl daemon-reload
systemctl enable bitcoind
systemctl start bitcoind
systemctl status bitcoind

# test bitcoind
runuser -l satoshi -c '/usr/bin/bitcoin-cli getblockchaininfo'