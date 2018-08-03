#!/bin/bash

jh='/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper'
jh_args=(\
    -windowType utility \
    -title "FileVault 2 Encryption" \
    -heading "Important" \
    -button1 "OK" \
    -icon /System/Library/CoreServices/Installer.app/Contents/Resources/Installer.icns \
    -alignHeading left \
    -description\
    )
message="In order to complete FileVault setup, please enter your password when prompted. \
	It is important that you complete this step to enable us to ensure the data on you Mac is protected."

"$jh" "${jh_args[@]}" "$message"