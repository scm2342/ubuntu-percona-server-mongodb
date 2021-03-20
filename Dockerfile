FROM ubuntu:focal-20210217

COPY entrypoint.sh /entrypoint.sh
COPY percona-keyring.gpg /etc/apt/trusted.gpg.d/
COPY percona-psmdb-44-release.list /etc/apt/sources.list.d/
COPY percona-pbm-release.list /etc/apt/sources.list.d/
RUN apt-get update && apt-get install -y gosu numactl percona-server-mongodb=4.4.4-6.focal percona-backup-mongodb=1.4.1-1.focal && rm -rf /var/lib/apt/lists/*
RUN useradd -u 1001 -r -g 0 -s /sbin/nologin -c "Default Application User" mongodb
RUN mkdir -p /data/db && chown 1001 /data/db
VOLUME [/data/db]
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 27017
USER 1001
CMD ["mongod"]
