#!/bin/bash

# This script takes a Patient ID number and returns the Patient Name

PatientID=$1

url="http://dwr-uat:4040/rxapi/odata/PatientsQuery%28%27"$PatientID"%27%29"

json=$(curl -s --request GET \
  --url $url \
  --header 'Alias: MAIN' \
  --header 'Authorization: Basic QVBJOjg0OWM1ZjE2ZGRjMw==' \
  --header 'Clinic-Code: 1' \
  --header 'Content-Type: application/json' \
  --header 'Prefer: return=representation' \
  --header 'Stock-Location-Id: 1' \
  --header 'cache-control: no-cache')
  
PatientName=$(echo $json | jq '.PatientName' | awk '{print substr($0, 2, length($0) - 2)}')