#!/bin/bash
nodes=(node59 node60 node61 node63 node64)
nodes1=(node39 node40 node41 node42 node58 node59 node60 node61 node63 node64 node65 node69 node79 node82 node92 node142 node143 node144 node145 node146 node147 node148)
RUN_HOME=$(cd `dirname $0`/..; pwd)
for node in ${nodes1[@]}
do       
if [[ ! " ${nodes[@]} " =~ " ${node} " ]]; then
         echo "++++++++++++++"  "$node" "+++++++++++++++="
         ssh $node "sh $RUN_HOME/hadoop/sbin/hadoop-daemon.sh stop journalnode"
fi
done


