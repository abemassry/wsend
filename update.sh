#!/usr/bin/env bash

wsend_base=$HOME/.wsend

curl -L -s -o $wsend_base/wsend https://raw.github.com/abemassry/wsend/master/wsend
chmod +x $wsend_base/wsend
curl -L -s -o $wsend_base/README.md https://raw.github.com/abemassry/wsend/master/README.md
curl -L -s -o $wsend_base/COPYING https://raw.github.com/abemassry/wsend/master/COPYING
curl -L -s -o $wsend_base/version https://raw.github.com/abemassry/wsend/master/version

#calling back update version
$wsend_base/wsend $@
