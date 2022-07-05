#!/bin/bash

apt-get install nginx

git clone https://github.com/lvaccaro/btctipserver/btctipserver.git
cd btctipserver
cargo build
cargo install --path .

