#!/bin/bash

# with sudo user
sudo apt-get update
sudo apt-get install -y \
  autoconf automake build-essential git libtool libgmp-dev libsqlite3-dev \
  python3 python3-pip net-tools zlib1g-dev libsodium-dev gettext
pip3 install --upgrade pip
sudo su - satoshi

# install lightningd
git clone https://github.com/ElementsProject/lightning.git
cd lightning
git checkout tags/v23.05

python3 -m virtualenv venv
source venv/bin/activate
pip install mako
./configure --enable-experimental-features
make
sudo make install
exit
