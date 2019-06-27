RUN_HOME=$(cd `dirname $0`/..; pwd)
hadoop dfs -rm -r /user/spark/historylog
hadoop dfs -mkdir -p /user/spark/historylog

sh $RUN_HOME/spark/sbin/start-history-server.sh

