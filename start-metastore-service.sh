RUN_HOME=$(cd `dirname $0`/..; pwd)
nohup $RUN_HOME/hive/bin/hive --service metastore >/dev/null 2>&1 &
echo "$!" > runjar.pid
