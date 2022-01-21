#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TIMESTAMP=$(date +"%Y-%m-%d %T")
TEMP=$($SCRIPT_DIR/temperature.py | awk -F'.' '{print $1}')
LUMENS=$($SCRIPT_DIR/lumens.py)
ROOM=$(echo $HOSTNAME | awk -F'-' '{print $2}')
echo '{"Timestamp":"'${TIMESTAMP}'","Room":"'${ROOM}'","Temperature":"'${TEMP}'","Lumens":"'${LUMENS}'"}'