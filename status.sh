#!/bin/bash


nodes=(node59 node60 node61 node63 node64)
for node in ${nodes[@]}
do
         echo "$node"
         ssh $node "jps"
done


