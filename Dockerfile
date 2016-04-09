# Set the base image
FROM alpine:3.3

MAINTAINER N<ns68751+n10n@gmail.com>

# Install OpenJDK 8, Maven and other software
RUN echo http://dl-4.alpinelinux.org/alpine/v3.3/main >> /etc/apk/repositories && \
    echo http://dl-4.alpinelinux.org/alpine/v3.3/community>> /etc/apk/repositories && \
    apk --update add openjdk8 automake autoconf bash gcc git libc-dev imake ncurses-dev openjdk8 openssh && \
    wget http://apache.claz.org/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz -O \
         /usr/lib/apache-maven-3.3.9-bin.tar.gz && \
    cd /usr/lib/ && \
    tar -xzvf apache-maven-3.3.9-bin.tar.gz && \
    rm -f apache-maven-3.3.9-bin.tar.gz
    \
    ln -s /usr/lib/jvm/java-1.8-openjdk/bin/javac /usr/bin/javac && \
    ln -s /usr/lib/jvm/java-1.8-openjdk/bin/jar /usr/bin/jar && \
    ln -s /usr/lib/apache-maven-3.3.9/bin/mvn /usr/bin/mvn
    cd /usr/local && \
    git clone -b forespray https://github.com/n10n/SpecialK.git  && \
    git clone -b master https://github.com/n10n/agent-service-ati-ia.git  && \
    git clone -b livelygig-api https://github.com/n10n/lgimporter.git && \
    \
    ln -s lgimporter GLoSEval && \
    cd SpecialK && \
    mvn -e -fn -DskipTests=true install prepare-package && \
    cd ../agent-service-ati-ia/AgentServices-Store && \
    mvn -e -fn -DskipTests=true install prepare-package && \
    cd ../../lgimporter && \
    mvn -e -fn -DskipTests=true install prepare-package && \
    mkdir zexe && \
    mkdir zexe/lib && \
    cp -rP GLoSEval/target/lib/* zexe/lib/ && \
    cp -rP GLoSEval/target/GLoSEval-0.1.jar zexe/lib/ && \
    cp -rP agent-service-ati-ia/AgentServices-Store/target/lib/* zexe/lib/ && \
    cp -rP SpecialK/target/lib/* zexe/lib/ && \
    echo CLASSPATH=\`find lib -name "*.jar" -exec echo -n {}: \\\;\`lib\/ >zexe/run.sh && \
    echo java -cp \$CLASSPATH com.biosimilarity.evaluator.spray.Boot -unchecked -deprecation -encoding utf8 -usejavacp >> zexe/run.sh && \
    chmod 755 zexe/run.sh && \
    cp GLoSEval/eval.conf zexe/ && \
    cp GLoSEval/log.properties zexe/ && \
    rm  zexe/lib/casbah*5.1*.jar && \
    rm  zexe/lib/casbah*5.1*.pom && \
    mkdir zexe/src  && \
    mkdir zexe/src/main && \
    mkdir zexe/src/main/resources && \
    mkdir zexe/src/main/resources/media && \
    cp GLoSEval/src/main/resources/media/queenbee64.txt zexe/src/main/resources/media  && \
    cd zexe 
#    run.sh
