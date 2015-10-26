#!usr

for INT in `seq $1 $2`
do
	if [ ! `yhcancel $INT` ]
	then
		echo "Job: $INT canceled!"
	else
		echo "Not exist Job: $INT!"
	fi
done

