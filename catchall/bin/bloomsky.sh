#!/bin/bash

bloomsky=$(curl -s -H 'Authorization: xtm_dtXvst7eodmnk7HI2-DUh9vUtg==' -H 'Content-Type: application/json' http://api.bloomsky.com/api/skydata/ | jq '.[].Data')
temp=$(echo ${bloomsky} | jq '.Temperature')
ts=$(echo ${bloomsky} | jq '.TS')
rain=$(echo ${bloomsky} | jq '.Rain')
humidity=$(echo ${bloomsky} | jq '.Humidity')
pressure=$(echo ${bloomsky} | jq '.Pressure')
uv=$(echo ${bloomsky} | jq '.UVIndex')
v=$(echo ${bloomsky} | jq '.Voltage')
night=$(echo ${bloomsky} | jq '.Night')
luminance=$(echo ${bloomsky} | jq '.Luminance')

echo -e '{"Time":'${ts}',"Temperature":'${temp}',Rain":'${rain}',"Humidity":'${humidity}',"Pressure":'${pressure}',"UV":'${uv}',"Voltage":'${v}',"Night":'${night}',"Lumens":'${luminance}',"Room":"outside"}'

