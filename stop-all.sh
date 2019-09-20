a="++++++++++++++"
echo "$a kill-runJar.sh $a"
sh kill-runJar.sh
echo "$a stop-spark-history-server.sh $a"
sh stop-spark-history-server.sh
echo "$a stop-mr-history-server.sh $a"
sh stop-mr-history-server.sh
echo "$a stop-nodemanager.sh $a"
sh stop-nodemanager.sh
echo "$a stop-resourcemanager.sh $a"
sh stop-resourcemanager.sh
echo "$a stop-zkfc.sh $a"
sh stop-zkfc.sh
echo "$a stop-datanode.sh $a"
sh stop-datanode.sh
echo "$a stop-namenode.sh $a"
sh stop-namenode.sh
echo "$a stop-journalNode.sh $a"
sh stop-journalNode.sh
echo "$a stop-zookeeper.sh $a"
sh stop-zookeeper.sh
