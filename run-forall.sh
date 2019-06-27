masterNode=$1
slaveNodes=($2 $3)

if [ $# -lt 1 ];then
  echo "should pass a command to run-all.sh"
  exit 1
fi

echo -e "$masterNode" "$4"
ssh $masterNode "$4"
echo -e "\n"

for node in ${slaveNodes[@]};do
   echo -e  "$node" "$4"
   ssh $node "$4"
   echo -e "\n"
done
