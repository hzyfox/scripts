RUN_HOME=$(cd `dirname $0`/..; pwd)
sh $RUN_HOME/hadoop/bin/hadoop namenode -format

