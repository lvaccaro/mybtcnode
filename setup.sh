#!/bin/bash

# setup user
useradd --home /home/satoshi --shell /usr/sbin/nologin satoshi
mkdir -p /home/satoshi
chown -R satoshi.satoshi /home/satoshi

# setup env
locale-gen en_US.UTF-8
sudo apt install vim git zsh curl wget tmux qrencode jq

# setup zsh / ohmyzsh
chsh -s $(which zsh) satoshi
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
