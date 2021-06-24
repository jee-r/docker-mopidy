#!/bin/sh

if [ -d /config ]; then
    if [ ! -f /config/mopidy.conf ]; then
        cp /etc/default/mopidy.conf /config/mopidy.conf
        mkdir -p /config/cache /config/data /config/images
    fi
else
    echo 'Please mount /config directory' >> /proc/self/fd/1
    exit 1
fi

/usr/bin/mopidy --config /config/mopidy.conf $@

    

