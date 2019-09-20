#!/bin/sh
if [ $# -lt 2 ];then
        echo "sh run.sh <source> [1:tail -f log]"
        exit 1
else
        full_qualified_class_name=com.fox.examples.sql.CacheTable
        jar_path=/home/feiwang/asplos/spark-json-optimize-examples/target/spark-json-optimize-examples-1.0-SNAPSHOT.jar
        class_name=`echo ${full_qualified_class_name##*.}`
        time_now=`date +%y_%d_%m:%T`
        equal="==========================="
        log_dir="logs/$class_name-$time_now.log"
        echo "full_qualified_class_name: " "${full_qualified_class_name}" | tee -a $log_dir
        echo "jar_path: " "${jar_path}" | tee -a $jar_path
        echo "class_name: " "${class_name}"| tee -a $log_dir
        echo "time_now:" "${time_now}"| tee -a $log_dir
        
      
        sourceFile=file:///home/feiwang/asplos/spark-json-optimize-examples/src/main/scala/resources/jsonpath/$1
        
        
        echo  "sourceFile:${sourceFile}"  | tee -a $log_dir
        exec_command="nohup /home/feiwang/asplos/spark/bin/spark-submit --master yarn --deploy-mode cluster --num-executors 30 --executor-cores 2 --driver-cores 2 --driver-memory 12g --executor-memory 8g --conf "spark.sql.json.writeCache=true"  --class $full_qualified_class_name $jar_path -s '$sourceFile' -db default >> $log_dir 2>&1 &"
        
        echo "exec_command: $exec_command" | tee -a $log_dir
        eval ${exec_command}
        if [ "$2" = "1" ];then
            echo "$equal" "log content" "$equal"
            tail -f $log_dir 
        fi
            
fi
