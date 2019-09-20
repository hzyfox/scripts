RUN_HOME=$(cd `dirname $0`/..; pwd)
namenode=node61
standby=node63
echo "start resourcemanager $namenode"
ssh $namenode "sh $RUN_HOME/hadoop/sbin/yarn-daemon.sh start resourcemanager"
echo "start resourcemanager $standby"
ssh $standby "sh $RUN_HOME/hadoop/sbin/yarn-daemon.sh start resourcemanager"

