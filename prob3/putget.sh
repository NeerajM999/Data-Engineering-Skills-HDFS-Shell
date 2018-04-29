#!/bin/bash

#################################################################################################
# Problem Statement: 	In your organization, each application team has their own dedicated space 
#			on HDFS. Now you are asked to create a transmission pipeline so teams can 
#			copy files from Local FS to Hadoop’s distributed FS & vice versa on need basis.
# Creator:		Neeraj Malhotra
# Date:			Jan 2018
# License:		You are free to copy, modify and distribute this file	
#
#################################################################################################

if [ "$#" -lt 3 ]
then
    echo "usage: ./putget.sh <direction> <src path> <dest path>"
    echo "direction = localToHdfs, hdfsToLocal"
    exit 1
fi

direction=$1
src=$2
dest=$3

echo "Starting putget Process"

if [ "$direction" == "localToHdfs" ]
then
	echo "Copying local:$src to hdfs:$dest"
	hadoop fs -put $src $dest
	
	if [ $? -ne 0 ]
	then
		echo "Failed to put $src to $dest"
		exit 1
	fi
	echo "Successfully put local:$src to hdfs:$dest"

elif [ "$direction" == "hdfsToLocal" ]
then
	echo "Copying hdfs:$src to local: $dest"
        hadoop fs -get $src $dest

        if [ $? -ne 0 ]
        then
                echo "Failed to get $src to $dest"
                exit 1
        fi
        echo "Successfully got hdfs:$src to local:$dest"

fi

echo "Finished putget Process"
exit 0
