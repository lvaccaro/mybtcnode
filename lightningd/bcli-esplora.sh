#!/bin/sh
# from https://github.com/lightningd/plugins/issues/112#issuecomment-818789990
# Recap: all one needs to do is to add --bitcoin-cli PATH/TO/bcli-esplora.sh. Simply export TEST_GETBLOCK=1 before running lightningd --bitcoin-cli ... in order to test esplora-only-getblock-mode (still needs local pruned bitcoind for hello world etc.).

exec </dev/null
ADD="/$(echo $* | grep -o "testnet\|signet")"
URL="https://mempool.space$ADD"

bcli() {
  test "$TEST_GETBLOCK" = 1 && return 1
  bitcoin-cli $*
}

getesplora() {
  END=$1; shift
  #wget -q -O- --header='Accept: application/json' "$URL/api/block/$2/$END"
  curl -s -o- -H='Accept: application/json' "$URL/api/block/$2/$END"
}

ARGS=$(echo $* | sed 's/-[^ ]\+ //')
OPTS=$(echo $* | tr ' ' '\n' | grep '^-')
shift $(echo $OPTS | wc -w)
test "$1" = "getblock" && {
  ARGN=$(echo $ARGS | wc -w)
  if test "$ARGN" = 2
  then
    bcli $OPTS $ARGS 2>/dev/null \
      || { printf '{"tx":'; getesplora txids $ARGS; printf '}'; }
  elif test "$ARGN" = 3
  then
    bcli $OPTS $ARGS 2>/dev/null \
      || { getesplora raw $ARGS | od -v -A n -t x1 \
             | tr -d ' \n'; echo; }
  fi
} || bitcoin-cli $OPTS $ARGS