# Set the base image
FROM alpine:3.3

LABEL description="Docker Base Image Required Software" version="0.1.0"
MAINTAINER N<ns68751+n10n@gmail.com>

# Install OpenJDK 8, Maven, SBT, NodeJS and other software
RUN \
    echo http://dl-4.alpinelinux.org/alpine/v3.3/main >> /etc/apk/repositories && \
    echo http://dl-4.alpinelinux.org/alpine/v3.3/community>> /etc/apk/repositories && \
    apk --update add bash git nodejs openjdk8 openssh-client && \
    wget http://apache.claz.org/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz -O \
         /usr/lib/apache-maven-3.3.9-bin.tar.gz && \
    wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.11/sbt-0.13.11.tgz -O \
         /usr/lib/sbt-0.13.11.tgz && \
    cd /usr/lib/ && \
    tar -xzvf apache-maven-3.3.9-bin.tar.gz && \
    tar -xzvf sbt-0.13.11.tgz && \
    \
    cd /usr/bin && \
    ln -s ../lib/jvm/java-1.8-openjdk/bin/javac /usr/bin/javac && \
    ln -s ../lib/jvm/java-1.8-openjdk/bin/jar /usr/bin/jar && \
    ln -s ../lib/apache-maven-3.3.9/bin/mvn /usr/bin/mvn && \
    ln -s ../lib/sbt/bin/sbt /usr/bin/sbt && \
    \
    rm -rf /var/cache/apk/* /usr/lib/apache-maven-3.3.9-bin.tar.gz /usr/lib/sbt-0.13.11.tgz \
    \
#EXPOSE 
#ENTRYPOINT ["/usr/local/entrypoint.sh"]
#CMD [ "/bin/bash" ]
