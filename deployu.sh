W_DIR=/usr/local
F_DIR=$W_DIR/frontui
  mkdir -p $W_DIR/frontuic $W_DIR/frontui && \
  cd $W_DIR/frontuic && \
  git clone -b synereo https://github.com/LivelyGig/ProductWebUI.git . && \
  sbt -verbose -J-Xmx2G -Dconfig.trace=loads stage && \
  mv $W_DIR/frontuic/server/target/universal/stage/* $W_DIR/frontui/ && \
  cd $W_DIR/frontui && \
  \
  touch $W_DIR/frontui/runsui.sh && \
  echo "bin/server -verbose -Dhttp.port=9000 -Dplay.crypto.secret=\"s3cr3t\" " |tee -a $W_DIR/frontui/runsui.sh && \
  chmod 755 $W_DIR/frontui/bin/server && $W_DIR/frontui/runsui.sh 
