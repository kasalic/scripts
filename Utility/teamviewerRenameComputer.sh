#!/bin/bash

computerName=$(scutil --get ComputerName)
echo $computerName

if [ -d /Applications/TeamViewerHost.app ]; then
	/Applications/TeamViewerHost.app/Contents/Helpers/TeamViewer_Assignment -api-token 14722208-Rcuvxh9FC6f5UhIqte6v -group "Dick White Referrals" -reassign -alias $computerName -grant-easy-access
	echo "success"
fi