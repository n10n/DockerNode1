# Set the base image
FROM alpine:3.3

MAINTAINER N<ns68751+n10n@gmail.com>

ENV W_DIR /usr/local
ENV S_DIR $W_DIR/splicious
ENV S_CMD splicious.sh
ADD splicious-alpine.sh /etc/init.d/$S_CMD

# Install OpenJDK 8, Maven and other software
RUN \
    chmod 755 /etc/init.d/$S_CMD && \
    ln -s /etc/init.d/$S_CMD /etc/runlevels/default/$S_CMD && \
#    update-rc.d /etc/init.d/$S_CMD defaults && \
    echo http://dl-4.alpinelinux.org/alpine/v3.3/main >> /etc/apk/repositories && \
    echo http://dl-4.alpinelinux.org/alpine/v3.3/community>> /etc/apk/repositories && \
    apk --update add openjdk8 automake autoconf bash gcc git libc-dev imake ncurses-dev openjdk8 openssh && \
    wget http://apache.claz.org/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz -O \
         /usr/lib/apache-maven-3.3.9-bin.tar.gz && \
    cd /usr/lib/ && \
    tar -xzvf apache-maven-3.3.9-bin.tar.gz && \
    rm -f apache-maven-3.3.9-bin.tar.gz && \
    \
    ln -s /usr/lib/jvm/java-1.8-openjdk/bin/javac /usr/bin/javac && \
    ln -s /usr/lib/jvm/java-1.8-openjdk/bin/jar /usr/bin/jar && \
    ln -s /usr/lib/apache-maven-3.3.9/bin/mvn /usr/bin/mvn && \
    \
    cd $W_DIR && \
    git clone -b forespray https://github.com/n10n/SpecialK.git  && \
    git clone -b master https://github.com/n10n/agent-service-ati-ia.git  && \
    git clone -b livelygig-api https://github.com/n10n/lgimporter.git && \
    \
    ln -s $W_DIR/lgimporter $W_DIR/GLoSEval && \
    cd $W_DIR/SpecialK && \
    mvn -e -fn -DskipTests=true install prepare-package && \
    cd $W_DIR/agent-service-ati-ia/AgentServices-Store && \
    mvn -e -fn -DskipTests=true install prepare-package && \
    cd $W_DIR/lgimporter && \
    mvn -e -fn -DskipTests=true install prepare-package && \
#    cd .. && \
    mkdir $S_DIR && \
    mkdir $S_DIR/lib && \
    mkdir $S_DIR/logs && \
    mkdir $S_DIR/src  && \
    mkdir $S_DIR/src/main && \
    mkdir $S_DIR/src/main/resources && \
    mkdir $S_DIR/src/main/resources/media && \
    cp -rP $W_DIR/SpecialK/target/lib/* $S_DIR/lib/ && \
    cp -rP $W_DIR/agent-service-ati-ia/AgentServices-Store/target/lib/* $S_DIR/lib/ && \
    cp -rP $W_DIR/GLoSEval/target/lib/* $S_DIR/lib/ && \
    cp -rP $W_DIR/GLoSEval/target/GLoSEval-0.1.jar $S_DIR/lib/ && \
#    echo CLASSPATH=\`find lib -name "*.jar" -exec echo -n {}: \\\;\`lib\/ >$S_DIR/run.sh && \
#    echo java -cp \$CLASSPATH com.biosimilarity.evaluator.spray.Boot -unchecked -deprecation -encoding utf8 -usejavacp >> zexe/run.sh && \
    echo java -cp "lib/*" com.biosimilarity.evaluator.spray.Boot \& >> $S_DIR/run.sh && \
    chmod 755 $S_DIR/run.sh && \
    cp GLoSEval/eval.conf $S_DIR/ && \
    cp GLoSEval/log.properties $S_DIR/ && \
    rm  $S_DIR/lib/casbah*5.1*.jar && \
    rm  $S_DIR/lib/casbah*5.1*.pom && \
    cp GLoSEval/src/main/resources/media/queenbee64.txt $S_DIR/src/main/resources/media  && \
    cd $S_DIR
     
EXPOSE 9876
CMD [ /etc/init.d/$S_CMD ]
