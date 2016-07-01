# Set the base image
FROM ubuntu

LABEL description="Node based on Ubuntu" version="0.1.0"
MAINTAINER N<ns68751+n10n@gmail.com>

ENV NODEADMINEMAIL admin@localhost
ENV NODEADMINPASS a
ENV DB_HOST 127.0.0.1
ENV DB_PORT 27017

ENV W_DIR /usr/local

#ADD ivy2.tar.gz /root/
#ADD m2.tar.gz /root/
#ADD sbt.tar.gz /root/

RUN \
    apt-get update \
    && apt-get -y install git nodejs openjdk-8-jdk subversion wget \
    && cd $W_DIR \
    && wget https://github.com/n10n/DockerNode/raw/master/entrypoint.sh -O $W_DIR/entrypoint.sh \
    && wget https://github.com/n10n/DockerNode/raw/master/installpkg.sh -O $W_DIR/installpkg.sh \
    && wget https://github.com/n10n/DockerNode/raw/master/installtools.sh -O $W_DIR/installtools.sh \
    && wget https://github.com/n10n/DockerNode/raw/master/deploy.sh -O $W_DIR/deploy.sh \
    && wget https://github.com/n10n/DockerNode/raw/master/reducesize.sh -O $W_DIR/reducesize.sh \
    && chmod 755 $W_DIR/entrypoint.sh $W_DIR/installpkg.sh $W_DIR/installtools.sh $W_DIR/deploy.sh $W_DIR/reducesize.sh\
    && ./installpkg.sh \
    && ./installtools.sh \
    && ./deploy.sh \
#    && ./reducesize.sh

WORKDIR $W_DIR
EXPOSE 80 8080 9876 9000
ENTRYPOINT ["/usr/local/entrypoint.sh"]
CMD [ "/usr/local/splicious/bin/splicious" ]
CMD [ "/usr/local/splicious/bin/frontui" ]
