#!/usr/bin/env bash

TZ=MST
TS=$(date +"%Y-%m-%dT%H:%M:%S")

function start_curl {
	if [[ ${1} ]]; then
		local PAGINATION="&starting_after=${1}"
	fi
	curl -s "https://api.stripe.com/v1/customers?limit=100${PAGINATION}" \
		-u "$(pass show denhac/stripe/api/key):"
}

FIRST_RESPONSE=$(start_curl)
ASSEMBLED=$(echo "${FIRST_RESPONSE}" | jq '.data[]')
LAST_OBJECT=$(echo "${FIRST_RESPONSE}" | jq -r '.data[-1].id')
HAS_MORE=$(echo "${FIRST_RESPONSE}" | jq '.has_more')

while [[ ${HAS_MORE} == true ]]; do
	NEXT_RESPONSE=$(start_curl "${LAST_OBJECT}")
	ASSEMBLED="${ASSEMBLED}"$(echo "${NEXT_RESPONSE}" | jq '.data[]')
	LAST_OBJECT=$(echo "${NEXT_RESPONSE}" | jq -r '.data[-1].id')
	HAS_MORE=$(echo "${NEXT_RESPONSE}" | jq '.has_more')
done

COUNT=$(echo "${ASSEMBLED}" | jq '.id' | wc -l)

jq --null-input -c --arg TS "${TS}" --arg CNT "${COUNT}" '{"Timestamp":$TS,"Accounts":$CNT}'
