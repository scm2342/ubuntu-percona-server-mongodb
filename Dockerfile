FROM ubuntu:focal-20211006

COPY entrypoint.sh /entrypoint.sh
COPY percona-keyring.gpg /etc/apt/trusted.gpg.d/
COPY percona-pbm-release.list percona-psmdb-50-release.list /etc/apt/sources.list.d/
RUN set -x \
  && apt-get update \
  && apt-get install -y gosu numactl percona-server-mongodb=5.0.4-3.focal percona-backup-mongodb=1.6.1-1.focal \
  && rm -rf /var/lib/apt/lists/* \
  && groupadd -g 996 mongodb && useradd -u 1001 -r -g 996 -s /sbin/nologin -c "Default Application User" mongodb \
  && mkdir -p /data/db && chown 1001 /data/db
VOLUME ["/data/db"]
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 27017
USER 1001
CMD ["mongod"]
