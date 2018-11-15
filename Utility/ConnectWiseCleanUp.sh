#!/bin/sh

PUBLIC_THUMBPRINT="$1"

if [ $# -eq 0 ]; then
	echo "Searching for installed Control clients..."
	PUBLIC_THUMBPRINTS=$(ls /opt/ | grep -o -w -E "screenconnect-[[:alnum:]]{16}" | grep -Eo ".{16}$")
	PUBLIC_THUMBPRINTS_ARR=($PUBLIC_THUMBPRINTS)

	if [ ${#PUBLIC_THUMBPRINTS} -eq 0 ] ; then
		echo
		echo "No Control clients found!"
		echo "Terminating cleanup"
		exit
	else
		echo "Found client(s) with the following public thumbprint(s):"
		echo
		echo "$PUBLIC_THUMBPRINTS"
		echo
		read -p "Confirm removal of all Control clients? " -n 1 -r
		
		if [[ $REPLY =~ ^[Yy]$ ]] ; then
			echo
			echo "Beginning cleanup..."
		else
			echo
			echo "Cleanup canceled"
			exit
		fi
		
		for thumbprintKey in "${!PUBLIC_THUMBPRINTS_ARR[@]}" ; do
			THUMBPRINT="${PUBLIC_THUMBPRINTS_ARR[$thumbprintKey]}"
			echo "Unloading client launch agents ($THUMBPRINT)..."

			NAMES_OF_USERS_STR2=$(ps aux | grep $THUMBPRINT | grep -Eo '^[^ ]+')
			NAMES_OF_USERS_ARR2=($NAMES_OF_USERS_STR2)

			for key2 in "${!NAMES_OF_USERS_ARR2[@]}" ; do
				POTENTIAL_USER2="${NAMES_OF_USERS_ARR2[$key2]}"
				if [ $POTENTIAL_USER2 != "root" ] ; then
					NON_ROOT_USER_ID2=$(id -u $POTENTIAL_USER2)
					echo "Unloading client launch agent for user $POTENTIAL_USER2"
					launchctl asuser $NON_ROOT_USER_ID2 launchctl unload /Library/LaunchAgents/screenconnect-$THUMBPRINT-onlogin.plist >/dev/null 2>&1
				fi
			done

			echo "Unloading client launch daemon ($THUMBPRINT)..."
			launchctl unload "/Library/LaunchDaemons/screenconnect-$THUMBPRINT.plist" >/dev/null 2>&1

			echo "Deleting client launch agents ($THUMBPRINT)..."
			rm "/Library/LaunchAgents/screenconnect-$THUMBPRINT-onlogin.plist" >/dev/null 2>&1
			rm "/Library/LaunchAgents/screenconnect-$THUMBPRINT-prelogin.plist" >/dev/null 2>&1

			echo "Deleting client launch daemon ($THUMBPRINT)..."
			rm "/Library/LaunchDaemons/screenconnect-$THUMBPRINT.plist" >/dev/null 2>&1

			echo "Deleting client installation directory ($THUMBPRINT)..."
			rm -rf "/opt/screenconnect-$THUMBPRINT.app/" >/dev/null 2>&1					
		done

		echo "Cleanup complete!"
		exit
	fi	
fi