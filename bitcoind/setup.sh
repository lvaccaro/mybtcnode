#!/bin/bash

# pre-requisite
sudo apt-get install build-essential libtool autotools-dev automake pkg-config bsdmainutils python3
sudo apt-get install libevent-dev libboost-dev
sudo apt install libsqlite3-dev
sudo apt install libminiupnpc-dev libnatpmp-dev
sudo apt-get install libzmq3-dev
sudo apt-get install libqrencode-dev

# fetch bitcoin
git clone https://github.com/bitcoin/bitcoin/
git checkout tags/v26.0
cd bitcoin
sh autogen.sh
./configure --disable-tests

# build berkley db 4.8
wget https://raw.githubusercontent.com/tinybike/get-bdb-4.8/master/install.sh
sh install.sh
autoreconf --install --force --prepend-include=/opt/bitcoin/src/bdb/build_unix/build/include/
./configure CPPFLAGS="-I/opt/bitcoin/src/bdb/build_unix/build/include/" LDFLAGS="-L/opt/bitcoin/src/bdb/build_unix/build/lib/" --disable-tests

#./configure CC=gcc-8 CXX="g++-8" LDFLAGS="-lstdc++fs" --without-bdb --disable-tests
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