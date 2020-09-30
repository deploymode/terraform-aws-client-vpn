#!/usr/bin/env bash

MODULE_ROOT=$1
CERT_DIR=$2
CONFIG_DIR=$3
DOMAIN=$4
STAGE=$5

CONFIG_PATH=$MODULE_ROOT/$CONFIG_DIR
CONFIG_FILE_PATH=$MODULE_ROOT/$CONFIG_DIR/$STAGE-client-config.ovpn
CERT_PATH=$MODULE_ROOT/$CERT_DIR

echo $CONFIG_FILE_PATH

[ ! -f $CONFIG_FILE_PATH ] && echo $CONFIG_FILE_PATH not found && exit 1

[ ! -d $CERT_PATH ] && echo $CERT_PATH not found && exit 1

RANDOM_STRING=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)

cp $CERT_DIR/$STAGE.$DOMAIN.crt $CONFIG_PATH && \
cp $CERT_DIR/$STAGE.$DOMAIN.key $CONFIG_PATH && \
[ -f $CONFIG_FILE_PATH ] && { 
    sed -i "s/cvpn-endpoint/$RANDOM_STRING.cvpn-endpoint/g" "$CONFIG_FILE_PATH"
} && {
    cat<<EOF >> $CONFIG_FILE_PATH

cert $STAGE.$DOMAIN.crt
key $STAGE.$DOMAIN.key
EOF
}
