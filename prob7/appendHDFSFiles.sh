#!/bin/bash

#################################################################################################
# Problem Statement: 	This utility will append data to an existing  HDFS file 
# Creator:		Neeraj Malhotra
# Date:			Jan 2018
# License:		You are free to copy, modify and distribute this file	
#
#################################################################################################

if [ "$#" -lt 2 ]
then
    echo "usage: ./appendHDFSFile.sh <src path>...  <dest path>"
    exit 1
fi

array=( $@ ) ## all arguments
length=${#array[@]} ## number of arguments passed in

src=${array[@]:0:$length-1} ## get all source parameters
dest="${array[$length-1]}" ## get last parameter which will be destination path


echo "Starting append process"

hadoop fs -appendToFile $src $dest

if [ $? -ne 0 ]
then
	echo "Failed to append $src to $dest"
        exit 1
fi

echo "Finished append process"
exit 0
