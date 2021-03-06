#!/bin/bash 

WDIR=$1
LIST=sample.list
FQDIR=$WDIR/0_merged_fastq

if [[ $# < 1 ]]
then
  >&2 echo "Usage: ./all_coverage.sh <working dir>"
  exit 1
fi

KK=`cat $LIST`
echo "["`date +%H:%M:%S`"] Started coverage/lane stats processing.."

for i in $KK 
do
  while [ $(jobs | wc -l) -ge 64 ] ; do sleep 5; done 
  ./one_coverage.sh $i $FQDIR > $i.coverage.out & 
done 
wait 

echo "["`date +%H:%M:%S`"] ALL DONE!"
