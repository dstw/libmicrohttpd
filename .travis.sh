#!/bin/bash

set -e

BOOTSTRAP_OPTIONS=
CONFIGURE_OPTIONS=()
export CFLAGS="-O0 -g"

./bootstrap ${BOOTSTRAP_OPTIONS}
./configure
make -j$(nproc)

if make -j$(nproc) check; then :; else
	test -f src/microhttpd/test-suite.log && cat src/microhttpd/test-suite.log
	exit 1
fi
