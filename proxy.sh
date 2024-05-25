#!/bin/bash

export cert="$(\
    yes no | \
    openconnect "$URL" 2>&1 >/dev/null | \
    grep 'servercert' | \
    cut -d ' ' -f 6)" \
    && \
    echo "$PASSWD" | \
    openconnect \
    --servercert $cert \
    --script-tun \
    --script "ocproxy -D 9052 -g -k 15" \
    --user=$NAME \
    --authgroup="$GROUP" \
    --passwd-on-stdin \
    $URL
