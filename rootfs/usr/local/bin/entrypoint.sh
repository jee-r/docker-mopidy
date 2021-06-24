#!/bin/sh

if [ -d /config ]; then
    if [ ! -f /config/mopidy.conf ]; then
        cp /config_default/mopidy.conf /config/mopidy.conf
        mkdir -p /config/{cache,data,images,iris,playlists}
    fi
else
    echo 'Please mount /config directory' >> /proc/self/fd/1
    exit 1
fi

/usr/bin/mopidy --config /config/mopidy.conf $@

    

