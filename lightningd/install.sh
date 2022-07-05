#!/bin/bash

# with sudo user
sudo apt-get update
sudo apt-get install -y \
  autoconf automake build-essential git libtool libgmp-dev libsqlite3-dev \
  python3 python3-pip net-tools zlib1g-dev libsodium-dev gettext
pip3 install --upgrade pip
sudo su - satoshi
pip3 install --user poetry

# install lightningd
git clone https://github.com/ElementsProject/lightning.git
cd lightning
git checkout tags/v0.11.1

python3.8 -m virtualenv venv
source venv/bin/activate
pip install poetry mako mrkd mistune==0.8.4
poetry install
./configure
poetry run make
sudo make install
exit
