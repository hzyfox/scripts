#!/bin/bash
nodes=(node59 node60 node61 node63 node64)
filePath="/usr/feiwang/zookeeper"
i=1
for node in ${nodes[@]}
do
if ssh $node "test -d $filePath";
    then
        
         ssh $node "rm -rf $filePath"
         ssh $node "mkdir -p $filePath/data"
         ssh $node "mkdir -p $filePath/logs"
         ssh $node "echo $i > $filePath/data/myid"
         i=`expr $i + 1`
    else
         ssh $node "mkdir -p $filePath/data"
         ssh $node "mkdir -p $filePath/logs"
         ssh $node "echo $i > $filePath/data/myid"
         i=`expr $i + 1`
fi
done


