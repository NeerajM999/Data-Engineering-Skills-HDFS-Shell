#!/bin/bash

#################################################################################################
# Problem Statement: 	In your organization, there are many teams who are supposed to share 
# 			HDFS cluster for data storage. Often teams end up placing their 
#			data in wrong directories or other team’s directories. 
#			You are asked to come up with a process which administrator team 
#			can use to create dedicated data storage areas for respective teams.
# Creator:		Neeraj Malhotra
# Date:			Jan 2018
# License:		You are free to copy, modify and distribute this file	
#
#################################################################################################

if [ "$#" -lt 1 ]
then
    echo "usage: setupDirectories.sh <path1> <path2> ... "
    exit
fi

echo "Starting setupDirectories Process"

hadoop fs -mkdir -p "$@"

if [ $? -ne 0 ]
then
	echo "Something went wrong in setting up directories. Please check you are giving absolute HDFS path like /hadoop/hdfs/mydata"
	exit 1
fi
echo "$@" "directories are ready for use."
echo "Finished setupDirectories Process"
exit 0
