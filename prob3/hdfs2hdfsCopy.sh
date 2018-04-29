#!/bin/bash

#################################################################################################
# Problem Statement: 	You need to create a utility to copy file(s) from source HDFS to destination
#			HDFS location with an option to retain file attributes on HDFS.
# Creator:		Neeraj Malhotra
# Date:			Jan 2018
# License:		You are free to copy, modify and distribute this file	
#
#################################################################################################

if [ "$#" -lt 3 ]
then
    echo "usage: ./hdfs2hdfsCopy.sh [force] [preserve_attr] <src HDFS paths>... <dest HDFS path>"
    echo "force = true|false, preserve_attr = true|false"
    exit 1
fi

array=( $@ ) ## all arguments
length=${#array[@]} ## number of arguments passed in

force=$1
attr=$2
src=${array[@]:2:$length-3} ## get all source parameters
dest="${array[$length-1]}" ## get last parameter which will be destination path

f=""
a=""

echo "Starting HDFS copy Process"

if [ "$force" == "true" ]
then
	f="-f"
fi

if [ "$attr" == "true" ]
then
	a="-pop" # out of topax, we only want to preserve owner and permissions so 'op'
fi	
	

echo "Copying hdfs:${src} to hdfs:$dest"

#echo "hadoop fs -cp ${f} ${a} ${src} ${dest}"

hadoop fs -cp ${f} ${a} ${src} ${dest}
	
if [ $? -ne 0 ]
then
	echo "Failed to copy ${src} to $dest"
	exit 1
fi

echo "HDFS copy process finished"
exit 0
