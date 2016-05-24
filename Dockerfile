# Set the base image
FROM livelygig/rsd

LABEL description="Node" version="0.2.0"
MAINTAINER N<ns68751+n10n@gmail.com>

ENV NODEADMINEMAIL admin@localhost
ENV NODEADMINPASS a

ENV MONGODB_HOST 127.0.0.1
ENV MONGODB_PORT 27017
ENV API_HOST 127.0.0.1
ENV API_PORT 9876
ENV DEPLOYMENT_MODE colocated
ENV DSLSERVER 127.0.0.1
ENV DSLPORT 5672
ENV BFCLSERVER 127.0.0.1
ENV BFCLPORT 5672
ENV DSLEPSSERVER 127.0.0.1
ENV DSLEPSPORT 5672

ENV RUNB_PORT 9876
ENV RUNF_PORT 9000
ENV W_DIR /usr/local

#ADD m2.tar.gz /root/
ADD m2scalaz210700.tar.gz /root/
ADD m2cup-jlex-configgy-prolog-pickling.tar.gz /root/
#ADD ivy2.tar.gz /root/
#ADD sbt.tar.gz /root/
COPY deploy.sh $W_DIR/
COPY entrypoint.sh $W_DIR/
COPY splicious.sh $W_DIR/splicious/
COPY frontui.sh $W_DIR/frontui/

RUN \
    cd $W_DIR \
    && chmod 755 $W_DIR/splicious/splicious.sh \
    && chmod 755 $W_DIR/frontui/frontui.sh \
    && chmod 755 $W_DIR/entrypoint.sh \
    && ./deploy.sh
    
ADD agentui.tar.gz $W_DIR/splicious
ADD scalabin.tar.gz $W_DIR/splicious
    
WORKDIR $W_DIR
EXPOSE 9876 9000 
ENTRYPOINT ["/usr/local/entrypoint.sh"]
CMD [ "/usr/local/splicious/runb.sh" ]
CMD [ "/usr/local/frontui/runf.sh" ]
