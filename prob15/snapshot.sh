#!/bin/bash

#################################################################################################
# Problem Statement: 	This utility will create, delete and rename HDFS snapshots 
# Creator:		Neeraj Malhotra
# Date:			Jan 2018
# License:		You are free to copy, modify and distribute this file	
#
#################################################################################################

# function to display menu
showMenu() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"	
	echo " M A I N - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Create Snapshot"
	echo "2. Delete Snapshot"
	echo "3. Rename Snapshot"
	echo "4. Mark Snapshotable"
	echo "5. Exit"
}

markSnapshotable() {
        local path
        read -p "Enter HDFS path [default: /]: " path
        if [ "$path" == "" ]
        then
                path='/'
        fi

	hdfs dfsadmin -allowSnapshot ${path}
	if [ $? -ne 0 ]
	then
		echo "Something went wrong in marking ${path} to snapshotable"
		exit 1
	fi
}


createSnapshot() {
	local path
        read -p "Enter HDFS path [default: /]: " path
        if [ "$path" == "" ]
        then
                path='/'
        fi

	hadoop fs -createSnapshot ${path}
        if [ $? -ne 0 ]
        then
                echo "Something went wrong in creating snapshot for ${path}"
                exit 1
        fi

}

deleteSnapshot() {
	local path
        read -p "Enter HDFS path [default: /]: " path

	local snapshot 
        read -p "Enter HDFS snapshot name : " snapshot

	 hadoop fs -deleteSnapshot ${path} ${snapshot}
        if [ $? -ne 0 ]
        then
                echo "Something went wrong in deleting ${snapshot} for ${path}"
                exit 1
        fi

}

renameSnapshot() {
	
	local path
        read -p "Enter HDFS path [default: /]: " path

	local oldName
        read -p "Enter old HDFS snapshot name : " oldName
	
	local newName
	read -p "Enter new HDFS snapshot name : " newName

        hadoop fs -renameSnapshot ${path} ${oldName} ${newName}
        if [ $? -ne 0 ]
        then
                echo "Something went wrong in renaming snapshot for ${path}"
                exit 1
        fi

}


getOption(){
	local choice
	read -p "Enter choice [ 1 - 5]: " choice
	case $choice in
		1) createSnapshot ;;
		2) deleteSnapshot ;;
		3) renameSnapshot ;;
		4) markSnapshotable ;;
		5) exit 0;;
		*) echo "Wrong option. Retry"
	esac
}

while true
do
	showMenu
	getOption
done

