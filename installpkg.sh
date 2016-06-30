if hash mvn 2 > /dev/null; then
  echo "mvn exists skipping"
else 
  wget http://apache.claz.org/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz -O \
         /usr/lib/apache-maven-3.3.9-bin.tar.gz
  tar -xzvf apache-maven-3.3.9-bin.tar.gz -C /usr/lib/
  cd /usr/bin; ln -s ../lib/apache-maven-3.3.9/bin/mvn /usr/bin/mvn
fi
if hash sbt 2> /dev/null; then
  echo "sbt exists skipping"
else
  wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.11/sbt-0.13.11.tgz -O \
         /usr/lib/sbt-0.13.11.tgz
  tar -xzvf sbt-0.13.11.tgz -C /usr/lib/ 
  cd /usr/bin; ln -s ../lib/sbt/bin/sbt /usr/bin/sbt
fi 
