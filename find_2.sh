#!/bin/bash 

PATH_WAY=~/WORKSPACE/15_10_12/work
for DIR in `ls -F ${PATH_WAY}`
do
    FILE_PATH="$PATH_WAY""/""$DIR"
    STEP=`cd $FILE_PATH && tail -n 6 pol-h5-2.txt | egrep -o "step [0-9]*"`
	NUM=${STEP#* }
	if [ $NUM -lt 1000000 ] 
	then
        echo $DIR
        echo $NUM
        #`cd $FILE_PATH && yhrun -n 1 ./*.out` &
	fi
done
wait
