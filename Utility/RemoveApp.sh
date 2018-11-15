#!/bin/bash

# Remove Application Script for Jamf Pro
# by Graham Pugh
#
# This script can delete apps that are sandboxed and live in /Applications

# The first parameter is used to kill the app. It should be the app name or path
# as required by the pkill command.
applicationPath="Microsoft Remote Desktop"

if [[ -z "${applicationPath}" ]]; then
    echo "No application specified!"
    exit 1
fi

echo "Closing application: ${applicationPath}"

pkill -f "${applicationPath}"

# echo "Removing application: ${applicationPath}"

# rm -rf "/Applications/${applicationPath}.app"
