#! /bin/bash
# findAppHome () {
#  local source="${BASH_SOURCE[0]}"
#  while [ -h "$source" ] ; do
#    local linked="$(readlink "$source")"
#    local dir="$( cd -P $(dirname "$source") && cd -P $(dirname "$linked") && pwd )"
#    source="$dir/$(basename "$linked")"
#  done
#  ( cd -P "$(dirname "$source")/" && pwd )
#}
#W_DIR="$(findAppHome)"
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
mkdir -p $S_DIR/libui $S_DIR/lib $S_DIR/logs $S_DIR/config && \
cd $S_DIR && \
#if [ ! -d $S_DIR/lib ]; then
#  svn checkout --force https://github.com/synereo/compilednode/trunk/lib 
#  rm -rf $S_DIR/lib/.svn
#fi
#if [ ! -d $S_DIR/libui ]; then
#  svn checkout --force https://github.com/synereo/compilednode/trunk/libui 
#  rm -rf $S_DIR/libui/.svn
#fi
if [ ! -d $S_DIR/scripts ]; then
  svn checkout --force https://github.com/synereo/gloseval/branches/1.0/scripts 
  rm -rf $S_DIR/scripts/.svn 
  svn checkout --force https://github.com/synereo/agent-service-ati-ia/branches/1.0/AgentServices-Store/scripts 
  rm -rf $S_DIR/scripts/.svn 
  svn checkout --force https://github.com/synereo/specialk/trunk/scripts 
  rm -rf $S_DIR/scripts/.svn
fi 
\
wget https://raw.githubusercontent.com/synereo/gloseval/1.0/eval.conf -O $S_DIR/config/eval.conf && \
wget https://raw.githubusercontent.com/synereo/gloseval/1.0/log.properties -O $S_DIR/log.properties && \
wget https://raw.githubusercontent.com/LivelyGig/ProductWebUI/master/server/src/main/resources/application.conf -O $S_DIR/config/ui.conf && \
\
cd $S_DIR && \
ln -fs config/eval.conf eval.conf && \
ln -fs config/ui.conf ui.conf && \
  \
  if [ 0 -eq $DOC ]; then
    if [ ! -d "$S_DIR/agentui" ]; then
      wget https://raw.githubusercontent.com/synereo/dockernode/master/agentui.tar.gz -O $S_DIR/agentui.tar.gz
      cd $S_DIR ; tar -xzvf agentui.tar.gz ; rm -f agentui.tar.gz
    fi 
    if [ ! -f "$S_DIR/bin/scala" ]; then
      wget https://raw.githubusercontent.com/synereo/dockernode/master/scalabin.tar.gz -O $S_DIR/scalabin.tar.gz
      cd $S_DIR ; tar -xzvf scalabin.tar.gz ; rm -f scalabin.tar.gz
    fi 
    if [ ! -f "$S_DIR/bin/splicious" ]; then
      wget https://raw.githubusercontent.com/synereo/dockernode/master/splicious.sh -O $S_DIR/bin/splicious
    fi 
    if [ ! -f "$S_DIR/bin/frontui" ]; then
      wget https://raw.githubusercontent.com/synereo/dockernode/master/frontui.sh -O $S_DIR/bin/frontui
    fi 
  fi
cd $W_DIR/ && \
chmod 755 $S_DIR/bin/*

echo "Deployer is exiting.......$?"
exit $?
