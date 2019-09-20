#!/bin/bash

if [ `whoami` != "root" ];then
    echo "请切换到root用户运行该脚本"
    exit 1
fi

nodes=(node59 node60 node61 node63 node64)
nodes1=(node39 node40 node41 node42 node58 node59 node60 node61 node63 node64 node65 node69 node79 node82 node92 node142 node143 node144 node145 node146 node147 node148)
filePath="/usr/feiwang/tmp"
parentDir="/usr/feiwang"
for node in ${nodes1[@]}
do
if [[ ! " ${nodes[@]} " =~ " ${node} " ]]; then
echo "not include" "$node"
# whatever you want to do when arr doesn't contain value
if ssh $node "test -d $filePath";
    then
         ssh $node "rm -rf $filePath"
         ssh $node "mkdir -p $filePath"
         ssh $node "chown -R feiwang:users $parentDir "
    else
         ssh $node "mkdir -p $filePath"
         ssh $node "chown -R feiwang:users $parentDir "
fi
else
 echo "include $node"
fi
done


