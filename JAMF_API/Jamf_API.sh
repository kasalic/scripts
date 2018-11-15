#!/bin/bash

#get access token
token=`curl -s -u reliable_layout:Uqhd381QGjL9 -X POST \
	https://api.jamfresearch.com:8443/uapi/auth/tokens \
	| jq -r .token`
  
device_ids=`curl -s -X GET -H "Authorization: Bearer $token" \
  https://api.jamfresearch.com:8443/uapi/inventory/obj/mobileDevice | jq -r '[.[].id]'`
  
for row in `echo $device_ids | jq -r .[]`; do
	curl -s -X GET -H "Authorization: Bearer $token" \
	https://api.jamfresearch.com :8443/uapi/mobileDevice/$row/detail \
	| jq -r '[.name, .osVersion] | join(", ")`
done