function run()
{
usage="Usage: create-tables.sh <classname> <resources_path> <pn> <rep>"
if [ $# -lt 4 ];then
        echo "$usage"
        exit 1
else
        SPARK_HOME=$(cd `dirname $0`; pwd)
        if [ ! -d "${SPARK_HOME}/logs" ];then
                mkdir ${SPARK_HOME}/logs
        fi

        full_qualified_class_name=$1
        resources_path=$2
        
        tableName=${resources_path##*%}
        pn=$3
        rep=$4
        jar_path=${SPARK_HOME}/examples/target/spark-json-optimize-examples-1.0-SNAPSHOT.jar
        class_name=`echo ${full_qualified_class_name##*.}`
        time_now=`date +%y_%d_%m:%T`
        equal="==========================="
        log_dir="${SPARK_HOME}/logs/$class_name-$tableName-$time_now.log"
        echo "full_qualified_class_name: " "${full_qualified_class_name}" | tee -a $log_dir
        echo "jar_path: " "${jar_path}" | tee -a $log_dir
        echo "class_name: " "${class_name}"| tee -a $log_dir
        echo `date` | tee -a $log_dir
        echo "log_dir:" "${log_dir}"| tee -a $log_dir
        exec_command="nohup ./bin/spark-submit --class $full_qualified_class_name --driver-cores 2 --driver-memory 16g --master yarn --deploy-mode cluster  --num-executors 16  --executor-memory 16g --executor-cores 2 --conf spark.app.name=CreateTable_$tableName --conf spark.sql.json.optimize=false --conf spark.sql.catalogImplementation=hive --conf spark.sql.json.writeCache=false ${jar_path} -s $resources_path -pn $pn -rep $rep > $log_dir 2>&1 &"
        echo "exec_command: $exec_command"| tee -a $log_dir
        eval ${exec_command}

        #echo "$equal" "log content" "$equal"
        #tail -f $log_dir

fi
}
_usage="Usage: run-test.sh  <pn> <rep>"
if [ $# -lt 2 ];then
        echo "$_usage"
        exit 1
fi
_full_qualified_class_name="com.fox.examples.sql.CreateTable1"
_pn=$1
_rep=$2

files=(basedata%%%toutiao_all_feeds)

for i in ${files[@]};do
   run $_full_qualified_class_name $i $_pn $_rep
   sleep 5
done
