My bitcoin node setup
===

My lightning box setup on odroid.

Inspired from [@Stadicus setup_clightning gist](https://gist.github.com/Stadicus/a05c3c5ac6a63cdcfe1aae2b77f17cba#file-setup_clightning-md).

### Tord
Onion proxy server.

### Bitcoind
Pruned node with soem resources constrains for my odroid, connected over tor proxy.

### Lightningd
C-lightning client with `bcli-esplora.sh` plugin to work with a pruned node and `commando` plugin for remote connection.

### Spruned
Spruned as light bitcoin node.

### Btctipserver
Donation server based on BDK library (for bitcoin) and EDK (for liquid).