#!/sbin/openrc-run

### BEGIN INIT INFO
# Provides:          Splicious
# Required-Start:    $local_fs $remote_fs $network $syslog
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start/stop Splicious server
### END INIT INFO

DESC="Splicious"
NAME=splicious
DATE=`date +%Y%m%d%H%M%S`
WORKINGDIR=/usr/local/splicious
PIDFILE=$WORKINGDIR/logs/$NAME.pid
LOGFILE=$WORKINGDIR/logs/$NAME-$DATE.log

if [ ! -d $WORKINGDIR/logs ]; then
   mkdir $WORKINGDIR/logs
fi
echo "Starting $DESC...$DATE" > $LOGFILE
#if [ ! -f $PIDFILE ]; then
  java -cp "$WORKINGDIR/lib/*" com.biosimilarity.evaluator.spray.Boot \
       -unchecked -deprecation -encoding utf8 -usejavacp < /dev/null >> $LOGFILE 2>&1 &
  echo $! > $PIDFILE
  echo "$DESC started $DATE" >> $LOGFILE
#else
#  echo "$DESC is already running" >> $LOGFILE
#fi
exit $?
