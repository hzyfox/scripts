RUN_HOME=$(cd `dirname $0`/..; pwd)
sh $RUN_HOME/hadoop/sbin/mr-jobhistory-daemon.sh start historyserver

