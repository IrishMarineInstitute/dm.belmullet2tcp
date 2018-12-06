#!/bin/sh
/usr/local/bin/kafkacat -C -X api.version.request=false -X broker.version.fallback=0.8.2.2 -b kafka01 -t ais-belmullet-json -p 0 -o -1 -u -q
