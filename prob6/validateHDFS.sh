#!/bin/bash

#################################################################################################
# Problem Statement: 	This utility will validate source and destination files using checksum 
# Creator:		Neeraj Malhotra
# Date:			Jan 2018
# License:		You are free to copy, modify and distribute this file	
#
#################################################################################################

if [ "$#" -lt 2 ]
then
    echo "usage: ./validateHDFS.sh <src path> <dest path>"
    exit 1
fi

src=$1
dest=$2

echo "Starting validation process"

src_ck=`hadoop fs -checksum $src | awk '{ print $NF }'`
echo "Checksum of source:$src file is:" $src_ck

## extract file name from source
filename=`echo $src | rev | cut -d"/" -f1 | rev`

echo "Copying $filename to $dest location"
hadoop fs -cp $src $dest
if [ $? -ne 0 ]
then
	echo "Failed to move $src to $dest"
        exit 1
fi

dest_ck=`hadoop fs -checksum $dest/$filename | awk '{ print $NF }'`
echo "Checksum of target:$dest/$filename is:" $dest_ck

if [ "$src_ck" == "$dest_ck" ]
then
	echo "File is copied successfully and validated"
else
	echo "Checksums didn't match, something went wrong"
	exit 1
fi

echo "Finished validation process"
exit 0
