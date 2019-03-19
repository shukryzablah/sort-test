#!/bin/bash


if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    echo "First parameter is mandatory. It represents the number of times to call malloc before running a sort test"
    exit 1
fi

#for bash
increment=100
arr_length=100
max_length=500
#loop through the algorithms and run each one with various lengths
for alg in "bubble" "counting" "insertion" "merge" "quick" "radix" "selection"
do
	arr_length=100
	echo "Running ${alg}"
	while [[ $arr_length -le $max_length ]]; do
		./sorttest ${alg} ${arr_length} 100 5 FALSE ${1}
		arr_length=$(( $arr_length + $increment )) 
	done
	./sorttest ${alg} 1000 100 5 FALSE ${1}
done


#for tcsh
## #! /usr/bin/env tcsh
#set algorithmList = ( bubble counting insertion merge quick radix selection )
#
#set increment = 100
#set arr_length = 100
#set max_length = 100
#foreach algorithm ( ${algorithmList} )
#	while(${arr_length} <= ${max_length})
#		./sorttest ${algorithm} ${arr_length} 100 5 FALSE $argv[1]
#	end
#	#./sorttest ${algorithm} 1000 100 5 FALSE $argv[1]
#end