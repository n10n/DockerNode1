#W_DIR=/usr/local
OCORE=omnicore-0.0.10.0-rel-linux64.tar.gz
  wget https://bintray.com/artifact/download/omni/OmniBinaries/$OCORE -O $W_DIR/$OCORE
  mkdir -p $W_DIR/omnicore; tar -xzvf $W_DIR/$OCORE -C $W_DIR/omnicore  --strip-components 1 
  # rm -f  /usr/local/$OCORE 
  mkdir $HOME/.bitcoin
  wget https://github.com/synereo/miscellaneous-/raw/master/.bitcoin/bitcoin.conf -O $HOME/.bitcoin/bitcoin.conf
  wget https://github.com/synereo/miscellaneous-/raw/master/.bitcoin/ostart.sh -O $W_DIR/omnicore/ostart.sh
  wget https://github.com/synereo/miscellaneous-/raw/master/.bitcoin/ostop.sh -O $W_DIR/omnicore/ostop.sh
  chmod 755 $W_DIR/omnicore/*.sh
  # cd /usr/bin ; ln -s ../local/omnicore/ostart.sh ostart.sh
  # cd /usr/bin ; ln -s ../local/omnicore/ostop.sh ostop.sh

MDB=mongodb-linux-x86_64-ubuntu1604-v3.2-latest.tgz
  wget http://downloads.mongodb.org/linux/$MDB -O $W_DIR/$MDB 
  mkdir -p $W_DIR/mongodb; tar -xzvf $W_DIR/$MDB -C $W_DIR/mongodb  --strip-components 1 
  # rm -f  /usr/local/$MDB
  wget https://github.com/synereo/miscellaneous-/raw/master/mongo/m.conf -O $W_DIR/mongodb/m.conf
  wget https://github.com/synereo/miscellaneous-/raw/master/mongo/mstart.sh -O $W_DIR/mongodb/mstart.sh
  wget https://github.com/synereo/miscellaneous-/raw/master/mongo/mstop.sh -O $W_DIR/mongodb/mstop.sh
  chmod 755 $W_DIR/mongodb/*.sh
  # cd /usr/bin ; ln -s ../local/mongodb/mstart.sh mstart.sh
  # cd /usr/bin ; ln -s ../local/mongodb/mstop.sh mstop.sh
