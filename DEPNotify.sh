#!/bin/sh

JAMFBIN=/usr/local/jamf/bin/jamf
CURRENTUSER=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

# Set DEPNotify Variables
DNLOG=/var/tmp/depnotify.log
DNPLIST=/var/tmp/DEPNotify.plist

#Setup DEPNotify preferences
sudo -u "$CURRENTUSER" defaults write menu.nomad.DEPNotify PathToPlistFile /var/tmp/
sudo -u "$CURRENTUSER" defaults write menu.nomad.DEPNotify RegisterMainTitle "Enter Asset Tag"
sudo -u "$CURRENTUSER" defaults write menu.nomad.DEPNotify RegistrationButtonLabel "Assign"
sudo -u "$CURRENTUSER" defaults write menu.nomad.DEPNotify UITextFieldUpperLabel "Asset Tag"
sudo -u "$CURRENTUSER" defaults write menu.nomad.DEPNotify UITextFieldUpperPlaceholder "DWR000000"
  
# Setup DEPNotify
echo "Command: MainTitle: Installing DWR Standard Build" >> $DNLOG
echo "Status: Installing some stuff..." >> $DNLOG

#Open DepNotify
sudo -u "$CURRENTUSER" /var/tmp/DEPNotify.app/Contents/MacOS/DEPNotify -jamf &

# get user input...
echo "Command: ContinueButtonRegister: Assign" >> $DNLOG
echo "Status: Just waiting for you..." >> $DNLOG

# hold here until the user enters something
while : ; do
  [[ -f $DNPLIST ]] && break
  sleep 1
done
  
# grab the Asset Tag from the plist that is created and use it to automatically name the computer
ASSETTAG=$(/usr/libexec/plistbuddy $DNPLIST -c "print 'Asset Tag'" | awk '{print toupper($0)}' )
  
COMPUTERNAME="${ASSETTAG}-${CURRENTUSER}"

# Change computer Name using jamf command and recon
$JAMFBIN setComputerName -name $COMPUTERNAME

# Do the things!
echo "Status: Enabling File Encryption" >> $DNLOG
$JAMFBIN policy -event FileVaultDEP

echo "Status: Installing NoMAD" >> $DNLOG
$JAMFBIN policy -event install_nomad

echo "Status: Setting Firmware Password" >> $DNLOG
$JAMFBIN policy -event set_firmwarepassword

echo "Status: Installing ScreenConnect" >> $DNLOG
$JAMFBIN policy -event install_screenconnect

echo "Status: Installing Forticlient" >> $DNLOG
$JAMFBIN policy -event install_forticlient

echo "Status: Configure Apple Remote Desktop Settings" >> $DNLOG
$JAMFBIN policy -event configure_ard

echo "Status: Installing Google Chrome" >> $DNLOG
$JAMFBIN policy -event install_chrome

echo "Status: Installing Microsoft Remote Desktop" >> $DNLOG
$JAMFBIN policy -event install_microsoftremotedesktop

echo "Status: Installing Word, Powerpoint Templates to Desktop" >> $DNLOG
$JAMFBIN policy -event install_templates

echo "Status: Installing Microsoft Office" >> $DNLOG
$JAMFBIN policy -event install_office

echo "Status: adding items to the Dock" >> $DNLOG
$JAMFBIN policy -event dock_rdc
sleep 10
$JAMFBIN policy -event dock_selfservice
sleep 10
$JAMFBIN policy -event dock_word
sleep 10
$JAMFBIN policy -event dock_outlook
sleep 10
$JAMFBIN policy -event dock_powerpoint
sleep 10
$JAMFBIN policy -event dock_excel

echo "Status: Please restart to complete File Encryption Settings" >>$DNLOG
echo "Command: ContinueButtonRestart: Restart" >> $DNLOG

# Pause until Restart Button is clicked
while : ; do
	  	[[ -f /var/tmp/com.depnotify.provisioning.restart ]] && break
	  	sleep 1
	  done

# Remove DEPNotify and the logs
rm -Rf /var/tmp/DEPNotify.app
rm -Rf $DNLOG
rm -Rf /var/tmp/DEPNotify.plist