#!/bin/bash

service cron start

# Put a continual polling `confd` process into the background to watch
# for changes every 10 seconds
confd >> /var/log/confd.log 2>&1 &

nginx -g 'daemon off;'