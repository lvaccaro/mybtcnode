#!/bin/bash

whoami
pwd

# setup user
useradd --home /home/satoshi -p satoshi satoshi
addgroup satoshi sudo
mkdir -p /home/satoshi
cp -rf * /home/satoshi/

chown -R satoshi.satoshi /home/satoshi
chown -R satoshi.satoshi /opt/

# setup env
locale-gen en_US.UTF-8
sudo apt install vim git zsh curl wget tmux qrencode jq pkg-config autoconf libtool

# setup zsh / ohmyzsh
chsh -s $(which zsh) satoshi
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

