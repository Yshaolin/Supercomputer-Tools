#!/bin/bash 

for DIR in `ls -F | grep /$`
do
    if [[ ! `ls $DIR | grep "pol-h5-2.txt"` ]]
    then
#        `cd $DIR && yhrun -n 1 ./*.out` &
    fi
done
wait
