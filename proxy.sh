#!/bin/bash

if [[ -z "${TOTPTOKEN}" ]]; then
    echo "TOTP TOKEN is missing"
else
    export TOTP=`oathtool --base32 -s 60s -d 6 --totp ${TOTPTOKEN}`
fi

export cert="$(\
    yes no | \
    openconnect "$URL" 2>&1 >/dev/null | \
    grep 'servercert' | \
    cut -d ' ' -f 6)" \


if [ "$GROUP" = "special" ]; then
    authstring="${PASSWD}"
else
    authstring="${PASSWD}\n${TOTP}"
fi

echo -e "${authstring}" | \
    openconnect \
    --servercert $cert \
    --script-tun \
    --script "ocproxy -D 9052 -g -k 15" \
    --user=$NAME \
    --authgroup="$GROUP" \
    --passwd-on-stdin \
    $URL
