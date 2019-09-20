#!/bin/sh
if [ $# -lt 2 ];then
        echo "sh run.sh <sourceFile> <partitionNumber> <recordEachPartition> [1:tail -f log]"
        exit 1
else
        full_qualified_class_name=com.fox.examples.sql.CreateTable
        jar_path=/home/feiwang/asplos/spark-json-optimize-examples/target/spark-json-optimize-examples-1.0-SNAPSHOT.jar
        class_name=`echo ${full_qualified_class_name##*.}`
        time_now=`date +%y_%d_%m:%T`
        equal="==========================="
        log_dir="logs/$class_name-$time_now.log"
        echo "full_qualified_class_name: " "${full_qualified_class_name}" | tee -a $log_dir
        echo "jar_path: " "${jar_path}" | tee -a $jar_path
        echo "class_name: " "${class_name}"| tee -a $log_dir
        echo "time_now:" "${time_now}"| tee -a $log_dir
        
      
        sourceFile=/home/feiwang/asplos/spark-json-optimize-examples/src/main/scala/resources/$1
        partitionNumber=$2
        recordEachPartition=$3
        echo  "sourceFile:${sourceFile}" "partitionNumber:${partitionNumber}" "recordEachPartition:${recordEachPartition}" | tee -a $log_dir
        exec_command="nohup /home/feiwang/asplos/spark/bin/spark-submit --master yarn --deploy-mode cluster --num-executors 30 --executor-cores 2 --driver-cores 2 --driver-memory 12G --executor-memory 8G  --class $full_qualified_class_name $jar_path -s '$sourceFile' -pn '$partitionNumber' -rep '$recordEachPartition' -db default >> $log_dir 2>&1 &"
        
        echo "exec_command: $exec_command" | tee -a $log_dir
        eval ${exec_command}
        if [ "$4" = "1" ];then
            echo "$equal" "log content" "$equal"
            tail -f $log_dir 
        fi
            
fi
