#!/bin/bash

if [ `whoami` != "root" ];then
    echo "请切换到root用户运行该脚本"
    exit 1
fi
nodes=(node39 node40 node41 node42 node58 node59 node60 node61 node63 node64  node79 node82 node92 node142 node143 node144 node145 node146 node147 node148)
for node in ${nodes[@]}
do
ntpdate node307
done


