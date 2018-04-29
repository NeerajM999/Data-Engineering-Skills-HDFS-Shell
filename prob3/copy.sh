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
    echo "usage: ./copy.sh <direction> <src path> <dest path>"
    echo "direction = localToHdfs, hdfsToLocal"
    exit 1
fi

direction=$1
src=$2
dest=$3

echo "Starting copy Process"

if [ "$direction" == "localToHdfs" ]
then
	echo "Copying $src from Local to HDFS location: $dest"
	hadoop fs -copyFromLocal $src $dest
	
	if [ $? -ne 0 ]
	then
		echo "Failed to copy $src to $dest"
		exit 1
	fi
	echo "Successfully copied local:$src to hdfs:$dest"

elif [ "$direction" == "hdfsToLocal" ]
then
	echo "Copying $src from HDFS to Local location: $dest"
        hadoop fs -copyToLocal $src $dest

        if [ $? -ne 0 ]
        then
                echo "Failed to copy $src to $dest"
                exit 1
        fi
        echo "Successfully copied hdfs:$src to local:$dest"

fi

echo "Finished copy Process"
exit 0
