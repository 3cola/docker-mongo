FROM ubuntu:14.04
MAINTAINER ecolaitis@gmail.com

# inspired by :
# https://leoengine.org/getting-start-with-docker-and-mongo/
# https://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
# https://github.com/reviewninja/docker-mongo-backup

# 0xEA312927 is the id of the mongo source signing key
# check it on http://keyserver.ubuntu.com

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 &&\
    echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list &&\
    apt-get update &&\
    apt-get install -y mongodb-org supervisor &&\
    apt-get clean all && apt-get autoremove -y

RUN mkdir -p /data/db &&\
    chgrp -R mongodb /data/db && chown -R mongodb /data/db

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY mongod.conf /etc/mongod.conf

EXPOSE 27017 

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
