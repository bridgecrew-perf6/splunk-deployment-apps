#!/usr/bin/env bash


curl -sko /dev/null -X POST \
	--data '{"username": "'$(pass show denhac/splunk/api/user)'", "password": "'$(pass show denhac/splunk/api/pass)'"}' \
	-c /tmp/cookie.txt \
	-H "Content-Type: application/json" \
	https://10.11.0.2/api/auth/login

curl -sk \
	-b /tmp/cookie.txt \
	-H "Content-Type: application/json" \
	https://10.11.0.2/proxy/network/api/s/default/stat/sta \
	| jq -c '.data[] | {mac, ip, is_wired, uptime, oui}'
