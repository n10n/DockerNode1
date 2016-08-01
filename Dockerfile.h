FROM alpine:latest
MAINTAINER Henry Till <henrytill@gmail.com>

ENV COMMIT bf27319466d48c5b7200f93fce11bf17af634935

ENV VERSION 0.1-bf27319

# TODO add mongodb, rabbitmq, and supervisord
RUN apk add --no-cache bash curl git openjdk7 java-cacerts tar

# Work around https://bugs.alpinelinux.org/issues/4128 for OpenJDK7
RUN rm /usr/lib/jvm/java-1.7-openjdk/jre/lib/security/cacerts
RUN ln -s /etc/ssl/certs/java/cacerts /usr/lib/jvm/java-1.7-openjdk/jre/lib/security/cacerts

# Install SBT
RUN curl -sL https://dl.bintray.com/sbt/native-packages/sbt/0.13.12/sbt-0.13.12.tgz > sbt.tar.gz
RUN tar xzf sbt.tar.gz
RUN mv sbt /usr/local
RUN ln -s /usr/local/sbt/bin/sbt /usr/local/bin/sbt

# Get GLoSEval
WORKDIR /tmp
RUN git clone --depth=50 -b native-packager https://github.com/synereo/gloseval.git

# Build GLoSEval
WORKDIR /tmp/gloseval
RUN git checkout -b local $COMMIT
RUN sbt update
RUN sbt universal:packageZipTarball
RUN mkdir -p /opt/node
RUN mv "target/universal/gloseval-$VERSION.tgz" /opt/node

# Clear build directories/caches
WORKDIR /
RUN rm -rf /tmp/gloseval*
RUN rm -rf /root/.ivy2

WORKDIR /opt
RUN tar xzf gloseval-$VERSION.tgz

# Create nodeuser
# RUN adduser nodeuser && addgroup nodeuser nodeuser
# RUN chown -R nodeuser:nodeuser /opt/node
# USER nodeuser

# COPY eval.conf /opt/node/eval.conf
