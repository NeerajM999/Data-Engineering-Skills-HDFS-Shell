#!/bin/bash

#################################################################################################
# Problem Statement: 	Change the user and group for a directory 
# Creator:		Neeraj Malhotra
# Date:			Jan 2018
# License:		You are free to copy, modify and distribute this file	
#
#################################################################################################

if [ "$#" -lt 3 ]
then
    echo "usage: setOwnership.sh username groupname <path> "
    exit
fi

owner=$1
group=$2
dir=$3

echo "Starting setOwnership Process"

hadoop fs -chown -R $owner $dir

if [ $? -ne 0 ]
then
	echo "Something went wrong in changing owner. Please check you are giving absolute HDFS path like /hadoop/hdfs/mydata"
	exit 1
fi

hadoop fs -chgrp -R $group $dir


if [ $? -ne 0 ]
then
        echo "Something went wrong in changing group. Please check you are giving absolute HDFS path like /hadoop/hdfs/mydata"
        exit 1
fi

echo "Owner and Group are changed for : $dir"
echo "Finished setOwnership Process"
exit 0
