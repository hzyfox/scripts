a="++++++++++++++"
echo "$a start-zookeeper.sh $a"
sh start-zookeeper.sh
echo "$a start-journalNode.sh $a"
sh start-journalNode.sh
echo "$a start-namenode.sh $a"
sh start-namenode.sh
echo "$a start-datanode.sh $a"
sh start-datanode.sh
echo "$a start-zkfc.sh $a"
sh start-zkfc.sh
echo "$a start-resourcemanager.sh $a"
sh start-resourcemanager.sh
echo "$a start-nodemanager.sh $a"
sh start-nodemanager.sh
echo "$a start-mr-history-server.sh $a"
sh start-mr-history-server.sh
echo "$a start-spark-history-server.sh $a"
sh start-spark-history-server.sh
echo "$a start-metastore-service.sh $a"
sh start-metastore-service.sh
