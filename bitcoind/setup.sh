#!/bin/bash

# build bitcoin
git clone https://github.com/bitcoin/bitcoin/
git checkout tags/v25.0
cd bitcoin
sh autogen.sh
./configure CC=gcc-8 CXX="g++-8" LDFLAGS="-lstdc++fs" --without-bdb --disable-tests
make
sudo make install

# setup systemd service
cp bitcoind.service /etc/systemd/system
systemctl daemon-reload
systemctl enable bitcoind
systemctl start bitcoind
systemctl status bitcoind

# test bitcoind
runuser -l satoshi -c '/usr/bin/bitcoin-cli getblockchaininfo'