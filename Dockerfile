# Arguments passed to "docker run" are shell-expanded to filenames that will have their blocks faulted in
# Directory arguments will include all files in the directory, but will not descend into sub-directories
# Setting the environment variable NO_EXIT will result in the container sleeping rather than exiting once complete
# docker run example: docker run invocaops/ebs_warmer /dir/*.ext /file.ext /dir
FROM ubuntu:14.04

RUN apt-get update \
    && apt-get install -y fio \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
