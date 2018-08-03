#!/bin/bash

jh='/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper'
jh_args=(\
    -windowType utility \
    -title "Enter title here" \
    -heading "Enter heading here" \
    -button1 "OK" \
    -icon /System/Library/CoreServices/Installer.app/Contents/Resources/Installer.icns \
    -alignHeading left \
    -description\
    )
message="Enter message for screen here."

"$jh" "${jh_args[@]}" "$message"