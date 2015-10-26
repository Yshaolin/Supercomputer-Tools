#!/bin/bash 

yhqueue | while read line
do
    JOBID=${line:0:6}
    if [[ `echo $line | grep " $1 "` ]]
    then 
        if [ $JOBID -ge $2 -a $JOBID -le $3 ]
        then
            yhcancel $JOBID
            echo "JOB: $JOBID canceled!"
        else
            echo "JGnore ID: $JOBID"
        fi
    fi
done
