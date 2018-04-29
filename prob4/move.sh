#!/bin/bash

#################################################################################################
# Problem Statement: 	This utility will allow moving files from Local FS to HDFS & vice versa 
# Creator:		Neeraj Malhotra
# Date:			Jan 2018
# License:		You are free to copy, modify and distribute this file	
#
#################################################################################################

if [ "$#" -lt 3 ]
then
    echo "usage: ./move.sh <direction> <src path> <dest path>"
    echo "direction = localToHdfs, hdfsToLocal, hdfsTohdfs"
    exit 1
fi

direction=$1
src=$2
dest=$3

echo "Starting move process"

if [ "$direction" == "localToHdfs" ]
then
	echo "Moving $src from Local to HDFS location: $dest"
	hadoop fs -moveFromLocal $src $dest
	
	if [ $? -ne 0 ]
	then
		echo "Failed to move $src to $dest"
		exit 1
	fi
	echo "Successfully moved local:$src to hdfs:$dest"

elif [ "$direction" == "hdfsToLocal" ]
then
	echo "Moving $src from HDFS to Local location: $dest"
        hadoop fs -moveToLocal $src $dest

        if [ $? -ne 0 ]
        then
                echo "Failed to move $src to $dest"
                exit 1
        fi
        echo "Successfully moved hdfs:$src to local:$dest"

elif [ "$direction" == "hdfsTohdfs" ]
then
	echo "Moving hdfs:$src to hdfs:$dest"
	hadoop fs -mv $src $dest

	if [ $? -ne 0 ]
        then
                echo "Failed to move $src to $dest"
                exit 1
        fi
        echo "Successfully moved hdfs:$src to hdfs:$dest"
else
	echo "Invalid $direction option"
	echo "usage: ./move.sh <direction> <src path> <dest path>"
	echo "direction = localToHdfs, hdfsToLocal, hdfsTohdfs"
    	exit 1
fi

echo "Finished move process"
exit 0
