if [ $# -lt 2 ];then
    echo "<input-file>" "<dest-file>"
    exit 1
fi

hadoop fs -put $1 $2
