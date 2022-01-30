#!/usr/bin/env bash

TZ=MST
TS=$(date +"%Y-%m-%dT%H:%M:%S")

STATUS=$(curl -s 'http://10.11.3.243/cgi-bin/webconf' --data-raw 'page=05' | w3m -dump -T text/html)

if [[ "${STATUS}" =~ 'The projector is currently on standby' ]]; then
	POWER="STANDBY"
elif [[ "${STATUS}" =~ 'Lamp Hours' ]]; then
	POWER="ON"
else
	POWER="OFF"
fi

jq --null-input -c --arg TS "${TS}" --arg PWR "${POWER}" '{Timestamp: $TS, Power: $PWR, Room: "Classroom"}'
