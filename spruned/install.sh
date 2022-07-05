#!/bin/bash

# with sudo user
sudo apt install libleveldb-dev python3-dev git virtualenv gcc g++
sudo su - satoshi

# with bitcoin user
git clone https://github.com/gdassori/spruned.git
cd spruned
virtualenv -p python3.5 venv
. venv/bin/activate
pip install -r requirements.txt
python setup.py install
exit
