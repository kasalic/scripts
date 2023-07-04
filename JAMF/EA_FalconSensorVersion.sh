#!/bin/bash

falcon_version=$(sudo /Applications/Falcon.app/Contents/Resources/falconctl stats | grep "version" | awk '{print $2}')

if [[ $falcon_version ]]; then
    echo "<result>$falcon_version</result>";
else
    echo "Falcon Sensor Version not found"
fi