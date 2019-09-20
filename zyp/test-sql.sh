function run()
{
usage="Usage: test-sql.sh <full_qualified_class_name> <ssn| eg. 7|8|9|10|11|12> <o eg. true|false> <cn eg. 5>"
if [ $# -lt 4 ];then
        echo "$usage"
        exit 1
else
        SPARK_HOME1=$(cd `dirname $0`; pwd)
        if [ ! -d "${SPARK_HOME1}/logs" ];then
                mkdir ${SPARK_HOME1}/logs
        fi
        full_qualified_class_name=$1
        ssn=$2
        o=$3
        cn=$4
        jar_path=/home/feiwang/asplos/spark-json-optimize-examples/target/spark-json-optimize-examples-1.0-SNAPSHOT.jar
        class_name=`echo ${full_qualified_class_name##*.}`
        time_now=`date +%y_%d_%m:%T`
        equal="==========================="
        log_dir="logs/$class_name-$time_now.log"
        echo "full_qualified_class_name: " "${full_qualified_class_name}" | tee -a $log_dir
        echo "jar_path: " "${jar_path}" | tee -a $log_dir
        echo "class_name: " "${class_name}"| tee -a $log_dir
        echo `date` | tee -a $log_dir
        echo "log_dir:" "${log_dir}"| tee -a $log_dir
        exec_command="nohup /home/feiwang/asplos/spark/bin/spark-submit --master yarn --deploy-mode cluster --class $full_qualified_class_name --driver-cores 1 --driver-memory 12g  --num-executors 30  --executor-memory 8g --executor-cores 1 --conf spark.app.name=TestSQL1_SQL-$ssn-$o  --conf spark.sql.catalogImplementation=hive  ${jar_path} -ssn $ssn -o $o -cn $cn > $log_dir 2>&1 &"
        echo "exec_command: $exec_command"| tee -a $log_dir
        eval ${exec_command}

        echo "$equal" "log content" "$equal"
        tail -f $log_dir

fi
}
_usage="Usage: test-sql.sh <ssn| eg. 7|8|9|10|11|12> <o eg. true|false> <cn eg. 5>"
if [ $# -lt 3 ];then
        echo "$_usage"
        exit 1
fi
_full_qualified_class_name="com.fox.examples.sql.TestSQL1"
_ssn=$1
_o=$2
_cn=$3

run $_full_qualified_class_name $1 $2 $3
