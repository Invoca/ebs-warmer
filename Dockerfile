FROM ubuntu:14.04

RUN apt-get update \
    && apt-get install -y fio \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
