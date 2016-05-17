W_DIR=/usr/local
S_DIR=$W_DIR/splicious
    cd $W_DIR && \
    git clone -b 1.0 https://github.com/synereo/specialk.git SpecialK && \
    git clone -b 1.0 https://github.com/synereo/agent-service-ati-ia.git  && \
    git clone -b 1.0 https://github.com/synereo/gloseval.git GLoSEval && \
    \
    cd $W_DIR/SpecialK && \
    mvn -e -fn -DskipTests=true install prepare-package && \
    cd $W_DIR/agent-service-ati-ia/AgentServices-Store && \
    mvn -e -fn -DskipTests=true install prepare-package && \
    cd $W_DIR/GLoSEval && \
    mvn -e -fn -DskipTests=true install prepare-package && \
    \
    mkdir -p $S_DIR/lib $S_DIR/logs $S_DIR/config && \
    cp -rP $W_DIR/SpecialK/target/lib/* $S_DIR/lib/ && \
    cp -rP $W_DIR/agent-service-ati-ia/AgentServices-Store/target/lib/* $S_DIR/lib/ && \
    cp -rP $W_DIR/GLoSEval/target/lib/* $S_DIR/lib/ && \
    cp -rP $W_DIR/GLoSEval/target/gloseval-0.1.jar $S_DIR/lib/ && \
    echo java -cp \"lib/*\" com.biosimilarity.evaluator.spray.Boot >> $S_DIR/run.sh && \
    \
    cp $W_DIR/GLoSEval/eval.conf $S_DIR/config/ && \
    cd $S_DIR && \
    ln -s config/eval.conf eval.conf && \
    cp $W_DIR/GLoSEval/log.properties $S_DIR/ && \
    echo java -cp \"lib/*\" com.biosimilarity.evaluator.spray.Boot >> $S_DIR/run.sh && \
    \
    cd $S_DIR/
    rm -rf $W_DIR/GLoSEval $W_DIR/SpecialK $W_DIR/agent-service-ati-ia && \
    rm -rf /var/cache/apk/* && \
    rm -f $S_DIR/lib/junit-3.8.1.jar $S_DIR/lib/junit-4.7.jar $S_DIR/lib/scalaz-core_2.10-6.0.4.jar $S_DIR/lib/slf4j-api-1.6.1.jar && \
    rm -f $S_DIR/lib/*.pom && \
    rm -f /usr/local/splicious/bin/._* && \

    chmod 755 $S_DIR/run.sh && \
    chmod 755 $S_DIR/splicious.sh && \
    chmod 755 $W_DIR/entrypoint.sh
