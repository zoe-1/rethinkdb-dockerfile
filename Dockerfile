FROM debian:jessie


MAINTAINER Daniel Alan Miller <dalanmiller@rethinkdb.com>

# CREDIT TO: https://github.com/rethinkdb/rethinkdb-dockerfiles
# Add the RethinkDB repository and public key
# "RethinkDB Packaging <packaging@rethinkdb.com>" http://download.rethinkdb.com/apt/pubkey.gpg
# ORIGINAL COMMAND RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 1614552E5765227AEC39EFCFA7E00EF33A8F2399
# changed to below.

RUN apt-key adv --keyserver pgp.mit.edu --recv 5C8DA04A 

RUN echo "deb http://download.rethinkdb.com/apt jessie main" > /etc/apt/sources.list.d/rethinkdb.list

ENV RETHINKDB_PACKAGE_VERSION 2.3.6~0jessie

RUN apt-get update \
        && apt-get install -y rethinkdb=$RETHINKDB_PACKAGE_VERSION \
        && rm -rf /var/lib/apt/lists/*

VOLUME ["/data"]

WORKDIR /data

CMD ["rethinkdb", "--bind", "all"]

#   process cluster webui
EXPOSE 28015 29015 8080


# Run rethinkdb on local machine
# docker run -p 28015:28015 -p 29015:29015 -p 8080:8080 image_name:latest


