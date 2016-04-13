#!/bin/bash
sed -i 's/dbHost = \"127.0.0.1\"/dbHost = \"'$MONGODB_HOST'\"/' /usr/local/splicious/eval.conf
exec "$@"
