        SPARK_HOME=$(cd `dirname $0`; pwd)
        if [ ! -d "${SPARK_HOME}/logs" ];then
                mkdir ${SPARK_HOME}/logs
        fi

        full_qualified_class_name="com.fox.examples.sql.motivation.CreateTable"
        jar_path=${SPARK_HOME}/examples/target/spark-json-optimize-examples-1.0-SNAPSHOT.jar
        class_name=`echo ${full_qualified_class_name##*.}`
        time_now=`date +%y_%d_%m:%T`
        equal="==========================="
        log_dir="${SPARK_HOME}/logs/$class_name-$time_now.log"
        echo "full_qualified_class_name: " "${full_qualified_class_name}" | tee -a $log_dir
        echo "jar_path: " "${jar_path}" | tee -a $log_dir
        echo "class_name: " "${class_name}"| tee -a $log_dir
        echo `date` | tee -a $log_dir
        echo "log_dir:" "${log_dir}"| tee -a $log_dir

        exec_command="nohup ./bin/spark-submit   --class $full_qualified_class_name --driver-cores 2 --driver-memory 8g --master yarn --deploy-mode cluster  --num-executors 4  --executor-memory 8g --executor-cores 2 --conf spark.sql.json.optimize=false --conf spark.sql.catalogImplementation=hive  ${jar_path} > $log_dir 2>&1 &"
        echo "exec_command: $exec_command"| tee -a $log_dir
        eval ${exec_command}

        echo "$equal" "log content" "$equal"
        tail -f $log_dir

fi

