#!/bin/bash

for DIR in `ls -F | grep /$`
do
    if [[ ! `cd $DIR && grep "step 1000000" pol-h5-2.txt` ]]
    then
        echo $DIR
    fi
done
