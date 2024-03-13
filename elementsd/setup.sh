git clone https://github.com/ElementsProject/elements --recursive
cd elements
sh autogen.sh
./configure --disable-tests

# build berkley db 4.8
wget https://raw.githubusercontent.com/tinybike/get-bdb-4.8/master/install.sh
sh install.sh
autoreconf --install --force --prepend-include=/opt/elements/src/bdb/build_unix/build/include/
./configure CPPFLAGS="-I/opt/elements/src/bdb/build_unix/build/include/" LDFLAGS="-L/opt/elements/src/bdb/build_unix/build/lib/"  --disable-tests

# build bitcoin
make
sudo make install