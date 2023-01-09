#!/bin/bash

ITEMNAME=$1
DOCKUTIL=/usr/local/bin/dockutil
SELFSERVICE=$($DOCKUTIL --find "$ITEMNAME")
CURRENTUSER=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

# Check if item is in Application Folder
if [[ -e "/Applications/$ITEMNAME.app" ]]; then
    echo "$ITEMNAME exists."; else
    echo "Application does not exist"
    exit 1
fi

# if [ ${SELFSERVICE:$FOUND:1} == n ]; then
if [ ${SELFSERVICE:$((${#ITEMNAME}+5)):1} == n ]; then
echo "Installing $ITEMNAME Icon"
$DOCKUTIL --add "/Applications/$ITEMNAME.app" /Users/"$CURRENTUSER"; else
echo "$ITEMNAME already in Dock"
fi