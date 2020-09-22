#!/usr/bin/env bash

MODULE_ROOT=$1
CERT_DIR=$2
CONFIG_DIR=$3
DOMAIN=$4

CONFIG_PATH=$MODULE_ROOT/$CONFIG_DIR
CONFIG_FILE_PATH=$MODULE_ROOT/$CONFIG_DIR/client-config.ovpn
CERT_PATH=$MODULE_ROOT/$CERT_DIR

echo $CONFIG_FILE_PATH

[ ! -f $CONFIG_FILE_PATH ] && echo $CONFIG_FILE_PATH not found && exit 1

[ ! -d $CERT_PATH ] && echo $CERT_PATH not found && exit 1

cp $CERT_DIR/client1.$DOMAIN.crt $CONFIG_PATH && \
cp $CERT_DIR/client1.$DOMAIN.key $CONFIG_PATH && \
[ -f $CONFIG_FILE_PATH ] && { 
    sed -i "s/cvpn-endpoint/random.cvpn-endpoint/g" "$CONFIG_FILE_PATH"
} && {
    cat<<EOF >> $CONFIG_FILE_PATH

cert client1.$DOMAIN.crt
key client1.$DOMAIN.key
EOF
}
