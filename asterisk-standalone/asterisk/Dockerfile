FROM ubuntu:22.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        asterisk \
        asterisk-core-sounds-en \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/lib/asterisk /var/spool/asterisk /var/log/asterisk \
    && chown -R asterisk:asterisk /var/lib/asterisk /var/spool/asterisk /var/log/asterisk

COPY config/extensions.conf /etc/asterisk/extensions.conf
COPY config/rtp.conf /etc/asterisk/rtp.conf
COPY config/modules.conf /etc/asterisk/modules.conf
COPY config/pjsip.conf.template /etc/asterisk/pjsip.conf.template
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /var/lib/asterisk

ENTRYPOINT ["/entrypoint.sh"]
CMD ["asterisk", "-f", "-C", "/etc/asterisk/asterisk.conf"]
