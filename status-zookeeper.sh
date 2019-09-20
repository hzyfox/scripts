#!/bin/bash
nodes=(node59 node60 node61 node63 node64)
RUN_HOME=$(cd `dirname $0`/..; pwd)
for node in ${nodes[@]}
do       
         echo $node
         ssh $node "sh $RUN_HOME/zookeeper/bin/zkServer.sh status"
done


