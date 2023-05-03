#!/bin/bash

SOURCEDIR="/Volumes/Antech/*"
TARGETDIR="/Volumes/Transfer/Scans/Lab/Antrim/"

for i in $SOURCEDIR
do
	if [[ $i == "VN.txt" ]]; then
		echo $i
	else
		mv $i $TARGETDIR
	fi
done
