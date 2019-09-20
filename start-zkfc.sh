RUN_HOME=$(cd `dirname $0`/..; pwd)
namenode=node61
standby=node63
echo "start zkfc $namenode"
ssh $namenode "sh $RUN_HOME/hadoop/sbin/hadoop-daemon.sh start zkfc"
echo "start zkfc $standby"
ssh $standby "sh $RUN_HOME/hadoop/sbin/hadoop-daemon.sh start zkfc"

