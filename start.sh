#!/usr/bin/env bash

set -e
set -x

cd /duplicity

sed -i -e "s/YOUR_APP_KEY/${APP_KEY}/" duplicity/backends/dpbxbackend.py
sed -i -e "s/YOUR_APP_SECRET/${APP_SECRET}/" duplicity/backends/dpbxbackend.py

./setup.py install

/usr/local/bin/duplicity --full-if-older-than ${MAX_AGE} /data dpbx:///${APP_NAME}
