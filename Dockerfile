# Set the base image
FROM livelygig/rsd

LABEL description="Node" version="0.2.0"
MAINTAINER N<ns68751+n10n@gmail.com>

ENV NODEADMINEMAIL admin@localhost
ENV NODEADMINPASS a

ENV DB_HOST 127.0.0.1
ENV DB_PORT 27017
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

#ADD ivy2.tar.gz /root/
#ADD m2.tar.gz /root/
#ADD sbt.tar.gz /root/
COPY deploy.sh $W_DIR/
COPY entrypoint.sh $W_DIR/

RUN \
    cd $W_DIR \
    && chmod 755 $W_DIR/entrypoint.sh \
    && chmod 755 $W_DIR/deploy.sh \
    && ./deploy.sh 
    
WORKDIR $W_DIR
EXPOSE 80 8080 9876 9000
ENTRYPOINT ["/usr/local/entrypoint.sh"]
CMD [ "/usr/local/splicious/splicious.sh" ]
CMD [ "/usr/local/frontui/frontui.sh" ]
