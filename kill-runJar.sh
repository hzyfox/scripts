RUN_HOME=$(cd `dirname $0`/..; pwd)
kill -9 `cat $RUN_HOME/sbin/runjar.pid`
