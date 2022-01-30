#!/usr/bin/env bash

RESPONSE=$(curl -s 'http://ads-b.inside.denhac.org/data/aircraft.json')

TIMESTAMP=$(date -d @$(echo "${RESPONSE}" | jq '.now') +"%Y-%m-%dT%H:%M:%S")

echo "${RESPONSE}" \
	| sed -r 's/[ ]+"/"/g' \
	| jq -c --arg TS "${TIMESTAMP}" '.aircraft[] | {timestamp: $TS, hex, squawk, flight, lat, lon, altitude, vert_rate, speed} | with_entries( select( .value != null ) )'

