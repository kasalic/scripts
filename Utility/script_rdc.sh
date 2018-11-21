#!/bin/sh

# Get the logged in user
loggedInUser=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
echo $loggedInUser

# get the cli executable
cli="/Applications/Microsoft Remote Desktop Beta.app/Contents/MacOS/Microsoft Remote Desktop Beta"
# general setting
myUUID=`uuidgen`
friendlyName="RXWorks"
hostAddress="192.168.1.10"
groupname="DWR"
username="DWR"'\'$loggedInUser
# display setting
resolution="0 0" #use "0 0" for native
colorDepth="32"
fullscreen="true"
scaleWindow="false"
# redirection
redirectSmartCards="false"
redirectPrinter="false"
soundPlaybackMode=2
# this will create the bookmark if it didnt exist yet
"$cli" --script bookmark write "$myUUID" --hostname "$hostAddress" --friendlyname "$friendlyName" --group "$groupname" --username "$username"
# this will update the bookmark, since the bookmark with uuid "myUUID" already exists
"$cli" --script bookmark write "$myUUID" --resolution "$resolution" --colordepth "$colorDepth" --fullscreen "$fullscreen" --scaling "$scaleWindow"
# setting 1 attribute at a time works too, but will be slower
"$cli" --script bookmark write "$myUUID" --redirectsmartcards "$redirectSmartCards"
"$cli" --script bookmark write "$myUUID" --redirectprinters "$redirectPrinter"
"$cli" --script bookmark write "$myUUID" --audioplayback "$soundPlaybackMode"