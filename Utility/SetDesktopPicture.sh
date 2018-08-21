#!/bin/bash
# $3 is the logged in user - default for most policies.  
/usr/bin/osascript <<ENDofOSAscript
tell Application "Finder"
set the desktop picture to {"Users:Shared:Screenshots:Scam.png"} as alias
end tell
ENDofOSAscript
exit 0