#!/bin/bash 
#find the program who's step < 1000000
#runing it use yhbatch -N * ./find_run.sh
 
for DIR in `ls -F | grep /$`
do
	STEP=`cd $DIR && tail -n 6 pol-h5-2.txt | egrep -o "step [0-9]+"`
	NUM=${STEP#* }
	if [ $NUM -lt 1000000 ] 
	then
#		echo $NUM
#		`cd $DIR && yhrun -n 1 ./*.out` &
	fi
done
wait
