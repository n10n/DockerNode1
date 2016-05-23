S_DIR=$W_DIR/splicious

## engine    
  cd $W_DIR && \
  if [ ! -d "frontuic" ]; then
#    git clone -b synereo https://github.com/LivelyGig/ProductWebUI.git frontuic && \
    git clone -b synereo https://github.com/LivelyGig/ProductWebUI.git frontuic 
#  else 
#    cd $W_DIR/frontuic ; git pull && \
  fi
  if [ ! -d "SpecialK" ]; then
#    git clone -b 1.0 https://github.com/synereo/specialk.git SpecialK && \
    git clone -b 1.0 https://github.com/synereo/specialk.git SpecialK 
#  else
#    cd $W_DIR/SpecialK; git pull && \
  fi
  if [ ! -d "agent-service-ati-ia" ]; then
#    git clone -b 1.0 https://github.com/synereo/agent-service-ati-ia.git  && \
    git clone -b 1.0 https://github.com/synereo/agent-service-ati-ia.git 
#  else
#    cd $W_DIR/agent-service-ati-ia; git pull && \
  fi
  if [ ! -d "GLoSEval" ]; then
#    git clone -b 1.0 https://github.com/synereo/gloseval.git GLoSEval && \
    git clone -b 1.0 https://github.com/synereo/gloseval.git GLoSEval 
#  else
#    cd $W_DIR/GLoSEval; git pull && \
  fi
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
  echo java -cp \"lib/*\" com.biosimilarity.evaluator.spray.Boot >> $S_DIR/runb.sh && \
  \
  cp $W_DIR/GLoSEval/eval.conf $S_DIR/config/ && \
  cp -rP $W_DIR/GLoSEval/scripts $S_DIR/ && \
  cd $S_DIR && \
  ln -s config/eval.conf eval.conf && \
  cp $W_DIR/GLoSEval/log.properties $S_DIR/ && \
  \
  chmod 755 $S_DIR/runb.sh && \
  \
  rm -rf /var/cache/apk/* && \
  rm -f $S_DIR/lib/junit-3.8.1.jar $S_DIR/lib/junit-4.7.jar && \
  rm -f $S_DIR/lib/scalaz-core_2.10-6.0.4.jar $S_DIR/lib/slf4j-api-1.6.1.jar && \
  rm $S_DIR/lib/*.pom && \
  rm -f /usr/local/splicious/bin/._* && \
  \
## New UI
  mkdir -p $W_DIR/frontui && \
  cd $W_DIR/frontuic && \
  sbt -verbose -J-Xmx2G -Dconfig.trace=loads stage && \
  mv $W_DIR/frontuic/server/target/universal/stage/* $W_DIR/frontui/ && \
  cd $W_DIR/frontui/ && \
  \
#  touch $W_DIR/frontui/runsui.sh && \
  echo "bin/server -verbose -Dhttp.port=9000 -Dplay.crypto.secret=\"s3cr3t\" " >> $W_DIR/frontui/runf.sh && \
  \
  chmod -v 755 $W_DIR/frontui/runf.sh && \

## reduce size
  rm -rf $W_DIR/GLoSEval/target && \
  rm -rf $W_DIR/GLoSEval/project/target && \
  rm -rf $W_DIR/SpecialK/target && \
  rm -rf $W_DIR/agent-service-ati-ia/target && \
  rm -rf $W_DIR/agent-service-ati-ia/AgentServices-Store/target && \
  rm -rf $W_DIR/frontuic/target  && \
  rm -rf $W_DIR/frontuic/sclient/target && \
  rm -rf $W_DIR/frontuic/shared/.js/target && \
  rm -rf $W_DIR/frontuic/shared/.jvm/target && \
  rm -rf $W_DIR/frontuic/project/target && \
  rm -rf $W_DIR/frontuic/project/project/target && \
  rm -rf $W_DIR/frontuic/server/target && \
#  rm -rf /root/.m2 /root/.sbt /root/.ivy2 /root/.zinc && \
echo " deploy.sh is exiting.......$?"
exit $?
