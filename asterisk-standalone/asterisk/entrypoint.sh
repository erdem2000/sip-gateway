#!/bin/sh
set -e

EXTIP="${EXTERNAL_IP:?EXTERNAL_IP must be set}"
EXTEN_1="${SIP_EXTEN_1:-1000}"
PASS_1="${SIP_PASSWORD_1:?SIP_PASSWORD_1 must be set}"
EXTEN_2="${SIP_EXTEN_2:-1001}"
PASS_2="${SIP_PASSWORD_2:?SIP_PASSWORD_2 must be set}"

sed -e "s/__EXTERNAL_IP__/${EXTIP}/g" \
    -e "s/__SIP_EXTEN_1__/${EXTEN_1}/g" \
    -e "s/__SIP_PASSWORD_1__/${PASS_1}/g" \
    -e "s/__SIP_EXTEN_2__/${EXTEN_2}/g" \
    -e "s/__SIP_PASSWORD_2__/${PASS_2}/g" \
    /etc/asterisk/pjsip.conf.template > /etc/asterisk/pjsip.conf

echo "=== Asterisk Standalone config ==="
echo "  external signaling/media: ${EXTIP}"
echo "  extension 1:              ${EXTEN_1}"
echo "  extension 2:              ${EXTEN_2}"
echo "  SIP listen:               UDP/TCP 5060"

exec "$@"
