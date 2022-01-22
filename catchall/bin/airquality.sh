#!/usr/bin/env bash

curl -s airquality-gray.inside.denhac.org/data.json | jq -c '. += {"box":"textiles"}'
