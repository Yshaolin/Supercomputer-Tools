#!/bin/bash 

yhqueue | while read line
do
    echo $ID
    JOBID=${line:0:6}
    ST=${line:39:2}
    if [[ $ST = $1 ]]
    then 
        if [ $JOBID -ge $2 -a $JOBID -lt $3 ]
        then
 #           yhcancel $JOBID
            echo "JOB: $JOBID canceled!"
        else
            echo "JGnore ID: $JOBID"
        fi
    fi
done
