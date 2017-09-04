#!/bin/bash

if [ -z "$ETCD_URL" ]; then
	nginx -g 'daemon off;'
else
    
    # Put a continual polling `confd` process into the background to watch
    # for changes every 10 seconds
	confd -interval 10 -backend $BACKEND_KIND -node $ETCD_URL -config-file /etc/confd/conf.d/nginx.toml >> /var/log/confd.log 2>&1 &

    nginx -g 'daemon off;'
fi