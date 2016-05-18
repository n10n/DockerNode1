# Set the base image
FROM livelygig/rsd

LABEL description="Node" version="0.2.0"
MAINTAINER N<ns68751+n10n@gmail.com>


ENV MONGODB_HOST 127.0.0.1
ENV MONGODB_PORT 27017
ENV RUN_PORT "9000"
ENV W_DIR /usr/local

ADD m2cup-jlex-configgy-prolog-pickling.tar.gz /root/
ADD m2.tar.gz /root/
ADD ivy2.tar.gz /root/
ADD sbt.tar.gz /root/

RUN \
    cd $W_DIR \
    && ./deploy.sh
    
ADD agentui.tar.gz $W_DIR/splicious
COPY splicious.sh $S_DIR/splicious
ADD scalabin.tar.gz $S_DIR/frontui

RUN \
    rm -f /usr/local/splicious/bin/._* && \
    chmod 755 $S_DIR/runb.sh && \
    chmod 755 $S_DIR/splicious.sh && \
    chmod 755 $W_DIR/entrypoint.sh
    
WORKDIR $S_DIR
EXPOSE [9876, 9000] 
#ENTRYPOINT ["/usr/local/entrypoint.sh"]
#CMD [ "/bin/bash" ]
