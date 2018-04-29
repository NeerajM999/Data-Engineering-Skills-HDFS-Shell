#!/bin/bash

#################################################################################################
# Problem Statement: 	Although teams have dedicated space provided now, they are having issues 
#			with permissions on those HDFS directories. When files are copied from 
#			Local to HDFS location, their permissions are not set as expected by 
#			downstream processes. Your client has asked you to set default permissions 
#			of any HDFS directories created as 775.
# Creator:		Neeraj Malhotra
# Date:			Jan 2018
# License:		You are free to copy, modify and distribute this file	
#
#################################################################################################

if [ "$#" -lt 1 ]
then
    echo "usage: setPerm.sh <path1> <path2> ... "
    exit
fi

echo "Starting setPerm Process"

hadoop fs -chmod -R 775 "$@"

if [ $? -ne 0 ]
then
	echo "Something went wrong in setting permissions. Please check you are giving absolute HDFS path like /hadoop/hdfs/mydata"
	exit 1
fi
echo "Permissions are set on following directories: $@"
echo "Finished setPerm Process"
exit 0
