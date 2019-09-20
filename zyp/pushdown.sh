#!/bin/sh
if [ $# -lt 2 ];then
        echo "sh run.sh <selectedSQLNumber> <optimize> <cycleNumber> [1:tail -f log]"
        exit 1
else
        full_qualified_class_name=com.fox.examples.sql.PushDown
        jar_path=/home/feiwang/asplos/spark-json-optimize-examples/target/spark-json-optimize-examples-1.0-SNAPSHOT.jar
        class_name=`echo ${full_qualified_class_name##*.}`
        time_now=`date +%y_%d_%m:%T`
        equal="==========================="
        log_dir="logs/$class_name-$time_now.log"
        echo "full_qualified_class_name: " "${full_qualified_class_name}" | tee -a $log_dir
        echo "jar_path: " "${jar_path}" | tee -a $jar_path
        echo "class_name: " "${class_name}"| tee -a $log_dir
        echo "time_now:" "${time_now}"| tee -a $log_dir
        
      
        selectedSQLNumber=$1
        optimize=$2
        cycleNumber=$3
        echo  "sourceFile:${sourceFile}" "partitionNumber:${partitionNumber}" "recordEachPartition:${recordEachPartition}" | tee -a $log_dir
        exec_command="nohup /home/feiwang/asplos/spark/bin/spark-submit --master yarn --deploy-mode cluster --num-executors 2 --executor-cores 1 --driver-cores 1 --driver-memory 4g --executor-memory 4g --conf "spark.driver.maxResultSize=4g" --conf "spark.app.name=PushDown_$selectedSQLNumber$optimize" --conf "spark.sql.broadcastTimeout=36000" --conf "spark.sql.crossJoin.enabled=true"  --class $full_qualified_class_name $jar_path -ssn '$selectedSQLNumber' -o '$optimize' -cn '$cycleNumber' >> $log_dir 2>&1 &"
        
        echo "exec_command: $exec_command" | tee -a $log_dir
        eval ${exec_command}
        if [ "$4" = "1" ];then
            echo "$equal" "log content" "$equal"
            tail -f $log_dir 
        fi
            
fi
