#!/usr/bin/env bash


URL="10.11.2.37"

RESPONSE=$(curl -sko /dev/null -w "%{http_code}\n" --max-time 30 "https://${URL}")

if [[ $(echo ${RESPONSE}) != 200 ]]; then
	exit 1
fi

STATUS=$(curl -sk -X GET "https://${URL}/hp/device/info_deviceStatus.html?tab=Home&menu=DevStatus" \
	--compressed | w3m -dump -T text/html)

#Cleaning...
#Front door open
#Initializing...
#Install black
#Install cyan
#Install magenta
#Install supplies
#Install yellow
#Load paper
#Power down mode
#Printing
#Ready
#Rear door open
#Shutting down
#Sleep mode on
#printer paper path

INK=( $(echo "${STATUS}" | grep -oE "[0-9]+%" | sed 's/^/"/g;s/$/"/g' | tr '\n' ' ') )
STATUS=$(echo "${STATUS}" | grep -oP '(?<=Status: ).*(?=Refresh.)' | awk '{$1=$1;print}')

# CMYK is the abbreviation for (C)yan,(M)agento,(Y)ellow,blac(K)
echo -e '{"cyan":'${INK[1]}',"magenta":'${INK[2]}',"yellow":'${INK[3]}',"black":'${INK[0]}',"status":"'${STATUS}'"}'
