#W_DIR=<DIR>
if [ -z "$W_DIR" ]; then
    echo "W_DIR not set, exiting..."
    exit 1
fi
S_DIR=$W_DIR/splicious
DOC=0
if [ ! -d $S_DIR ]; then
  git clone -b master https://github.com/synereo/compilednode.git $S_DIR 
else 
  cd $S_DIR ; git checkout -f; git pull
fi
mkdir -p $S_DIR/bin $S_DIR/libui $S_DIR/lib $S_DIR/logs $S_DIR/config && \
cd $S_DIR && \
if [ ! -d $S_DIR/scripts ]; then
  svn checkout --force https://github.com/synereo/gloseval/branches/1.0/scripts 
  rm -rf $S_DIR/scripts/.svn 
  svn checkout --force https://github.com/synereo/agent-service-ati-ia/branches/1.0/AgentServices-Store/scripts 
  rm -rf $S_DIR/scripts/.svn 
  svn checkout --force https://github.com/synereo/specialk/trunk/scripts 
  rm -rf $S_DIR/scripts/.svn
fi 
\
curl -L https://github.com/synereo/gloseval/raw/1.0/eval.conf -o $S_DIR/config/eval.conf && \
curl -L https://github.com/synereo/gloseval/raw/1.0/log.properties -o $S_DIR/log.properties && \
curl -L https://github.com/LivelyGig/ProductWebUI/raw/master/server/src/main/resources/application.conf -o $S_DIR/config/ui.conf && \
\
cd $S_DIR && \
ln -fs config/eval.conf eval.conf && \
ln -fs config/ui.conf ui.conf && \
  \
  if [ 0 -eq $DOC ]; then
    if [ ! -d "$S_DIR/agentui" ]; then
      curl -L https://raw.githubusercontent.com/synereo/dockernode/master/agentui.tar.gz -o $S_DIR/agentui.tar.gz
      cd $S_DIR ; tar -xzvf agentui.tar.gz ; rm -f agentui.tar.gz
    fi 
    if [ ! -f "$S_DIR/bin/scala" ]; then
      curl -L https://raw.githubusercontent.com/synereo/dockernode/master/scalabin.tar.gz -o $S_DIR/scalabin.tar.gz
      cd $S_DIR ; tar -xzvf scalabin.tar.gz ; rm -f scalabin.tar.gz
    fi 
    if [ ! -f "$S_DIR/bin/splicious" ]; then
      curl -L https://raw.githubusercontent.com/synereo/dockernode/master/splicious.sh -o $S_DIR/bin/splicious
    fi 
    if [ ! -f "$S_DIR/bin/frontui" ]; then
      curl -L https://raw.githubusercontent.com/synereo/dockernode/master/frontui.sh -o $S_DIR/bin/frontui
    fi 
  fi
cd $W_DIR/ && \
chmod 755 $S_DIR/bin/*

echo "Deployer is exiting.......$?"
exit $?
