#!/bin/bash

if [ `whoami` != "root" ];then
    echo "请切换到root用户运行该脚本"
    exit 1
fi

nodes=(node59 node60 node61 node63 node64)
filePath="/usr/feiwang/tmp"
parentDir="/usr/feiwang"
for node in ${nodes[@]}
do
if ssh $node "test -d $filePath";
    then
         ssh $node "rm -rf $filePath"
         ssh $node "mkdir -p $filePath"
         ssh $node "chown -R feiwang:users $parentDir "
    else
         ssh $node "mkdir -p $filePath"
         ssh $node "chown -R feiwang:users $parentDir "
fi
done


