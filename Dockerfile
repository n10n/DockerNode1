# Set the base image
FROM livelygig/rsd

LABEL description="Node" version="0.2.0"
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
    cd $W_DIR \
    && wget https://github.com/n10n/DockerNode/raw/master/entrypoint.sh -O $W_DIR/entrypoint.sh \
# rsd already has mvn and sbt
#    && wget https://github.com/n10n/DockerNode/raw/master/installpkg.sh -O $W_DIR/installpkg.sh \
    && wget https://github.com/n10n/DockerNode/raw/master/deploy.sh -O $W_DIR/deploy.sh \
    && wget https://github.com/n10n/DockerNode/raw/master/reducesize.sh -O $W_DIR/reducesize.sh \
# mongodb and omnicore is not supported on Alpine 
#    && chmod 755 $W_DIR/entrypoint.sh $W_DIR/installpkg.sh $W_DIR/installtools.sh $W_DIR/deploy.sh $W_DIR/reducesize.sh\
    && chmod 755 $W_DIR/entrypoint.sh $W_DIR/deploy.sh $W_DIR/reducesize.sh \
    && ./deploy.sh \
#    && ./reducesize.sh
    
WORKDIR $W_DIR
EXPOSE 80 8080 9876 9000
ENTRYPOINT ["/usr/local/entrypoint.sh"]
CMD [ "/usr/local/splicious/bin/splicious" ]
CMD [ "/usr/local/splicious/bin/frontui" ]
