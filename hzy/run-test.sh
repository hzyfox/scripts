usage="Usage: run-test.sh  <full_qualified_class_name>  (it|pj)"
if [ $# -lt 2 ];then
        echo "$usage"
        exit 1
else
        SPARK_HOME=$(cd `dirname $0`; pwd)
        if [ ! -d "${SPARK_HOME}/logs" ];then
                mkdir ${SPARK_HOME}/logs
        fi

        full_qualified_class_name=$1
        functype=$2
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

        case $functype in
          (it)
            pn=$3
            rep=$4
            exec_command="nohup ./bin/spark-submit --class $full_qualified_class_name --master yarn --deploy-mode cluster  --num-executors 2  --executor-memory 4g --executor-cores 2 --conf spark.sql.json.optimize=false --conf spark.sql.catalogImplementation=hive --conf spark.sql.json.writeCache=false ${jar_path} -ft it -tn json_test -pn $pn -rep $rep > $log_dir 2>&1 &"
            echo "exec_command: $exec_command"| tee -a $log_dir
            eval ${exec_command}
            ;;
          (pj)
            exec_command="nohup ./bin/spark-submit   --class $full_qualified_class_name --master yarn --deploy-mode cluster  --num-executors 2  --executor-memory 4g --executor-cores 2 --conf spark.sql.json.optimize=false --conf spark.sql.catalogImplementation=hive --conf spark.sql.json.writeCache=true ${jar_path} -ft pj -tn default_json_test > $log_dir 2>&1 &"
            echo "exec_command: $exec_command"| tee -a $log_dir
            eval ${exec_command}
            ;;
          (*)
            echo "$usage"
            exit 1
            ;;
        esac

        echo "$equal" "log content" "$equal"
        tail -f $log_dir

fi

