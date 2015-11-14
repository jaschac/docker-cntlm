#!/bin/bash
#
# This scripts sets the container up the container with the desiered service(s) properly running.
#

set -e

: ${CNTLM_DOMAIN:=""}
: ${CNTLM_PASSLM:=""}
: ${CNTLM_PASSNT:=""}
: ${CNTLM_PASSNTLMv2:=""}
: ${CNTLM_PROXY_PORT:="3128"}
: ${CNTLM_PROXY_URL:=""}
: ${CNTLM_USERNAME:=""}

# Check if mandatory args were passed
if [[ -z $CNTLM_USERNAME || -z $CNTLM_DOMAIN || -z $CNTLM_PROXY_URL ]]
then
    echo "CNTLM_USERNAME, CNTLM_DOMAIN and CNTLM_PROXY_URL are mandatory!" >> /dev/stderr
    exit 1
fi

# Check if any of the password args was passed
password=($CNTLM_PASSLM $CNTLM_PASSNT $CNTLM_PASSNTLMv2)
if [ ${#password[@]} -eq 0 ]
then
    echo "Either CNTLM_PASSLM or CNTLM_PASSNT or CNTLM_PASSNTLMv2 must be passed!" >> /dev/stderr
    exit 1
fi

# Inject user-defined data into /etc/cntlm.conf
if [ -f /etc/cntlm.conf ]
then
    sed -i 's/<CNTLM_DOMAIN>/'${CNTLM_DOMAIN}/g /etc/cntlm.conf
    sed -i 's/<CNTLM_PASSLM>/'${CNTLM_PASSLM}/g /etc/cntlm.conf 
    sed -i 's/<CNTLM_PASSNT>/'${CNTLM_PASSNT}/g /etc/cntlm.conf
    sed -i 's/<CNTLM_PASSNTLMv2>/'${CNTLM_PASSNTLMv2}/g /etc/cntlm.conf
    sed -i 's/<CNTLM_PROXY_PORT>/'${CNTLM_PROXY_PORT}/g /etc/cntlm.conf
    sed -i 's/<CNTLM_PROXY_URL>/'${CNTLM_PROXY_URL}/g /etc/cntlm.conf
    sed -i 's/<CNTLM_USERNAME>/'${CNTLM_USERNAME}/g /etc/cntlm.conf
fi

# Build and install cntlm
if [ -d /usr/local/src/cntlm-0.92.3/ ]
then
    cd /usr/local/src/cntlm-0.92.3/
    ./configure
    make
    make install
fi

# Start cNTLM in foreground
cntlm -f -g -c /etc/cntlm.conf
