#!/bin/bash

# Set variables
jssURL="https://dwr.jamfcloud.com"
ea_name="EA Test"
ea_value="Yes"
serial=$(ioreg -rd1 -c IOPlatformExpertDevice | awk -F'"' '/IOPlatformSerialNumber/{print $4}')

# Create XML
	cat << EOF > /private/tmp/ea.xml
<computer>
	<extension_attributes>
		<extension_attribute>
			<name>$ea_name</name>
			<value>$ea_value</value>
		</extension_attribute>
	</extension_attributes>
</computer>
EOF

# Upload

curl -sfku "$4":"$5" "${jssURL}/JSSResource/computers/serialnumber/${serial}" -T /private/tmp/ea.xml -X PUT