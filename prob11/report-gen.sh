#!/bin/bash

#################################################################################################
# Problem Statement: 	This utility will generate reports based on option selected 
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
	echo "1. Generate Stat Report"
	echo "2. Generate count Report"
	echo "3. Generate Free Space Report"
	echo "4. Generate Disk Usage Report"
	echo "5. Exit"
}

statReport() {
	local path
	read -p "Enter HDFS path [default: /]: " path
	if [ "$path" == "" ]
	then
		path='/'
	fi

	echo "Type,User,Group,Size,Replication,Modification Date,Item" > stat.report
	hadoop fs -stat "%F,%u,%g,%b,%r,%y,%n" "${path}" >> stat.report
}

countReport() {
	local path
        read -p "Enter HDFS path [default: /]: " path
        if [ "$path" == "" ]
        then
                path='/'
        fi

        hadoop fs -count -q -h -v "${path}" >> count.report

}

freeSpaceReport() {
	local path
        read -p "Enter HDFS path [default: /]: " path
        if [ "$path" == "" ]
        then
                path='/'
        fi

        hadoop fs -df -h  "${path}" >> freeSpace.report

}

diskUsageReport() {
	local path
        read -p "Enter HDFS path [default: /]: " path
        if [ "$path" == "" ]
        then
                path='/'
        fi

        hadoop fs -du -s -h  "${path}" >> diskUsage.report

}

getOption(){
	local choice
	read -p "Enter choice [ 1 - 5]: " choice
	case $choice in
		1) statReport ;;
		2) countReport ;;
		3) freeSpaceReport ;;
		4) diskUsageReport ;;
		5) exit 0;;
		*) echo "Wrong option. Retry"
	esac
}

while true
do
	showMenu
	getOption
done

