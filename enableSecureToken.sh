#!/bin/bash


FV2USERS="$(fdesetup list)"

# echo $FV2USERS

if [[ ${FV2USERS} = *"cadmin"* ]] ; 
then
    /bin/echo "cadmin is already an FV2 enabled User"
else
    osascript -e 'tell app "System Events" to display dialog "In order to complete FileVault setup, please enter your password when prompted."'
fi

echo $FV2USERS
