#!/bin/bash
for FILE in `find ./pol-*-SD-13 -name pol-*.out`
do 
#       echo $FILE
	PAT=${FILE%/*}
#	echo $PAT
	`cd $PAT && yhrun -n 1 ./pol-*.out` &
done
wait
