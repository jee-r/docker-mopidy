# mopidy docker image

[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/j33r/mopidy?style=flat-square)](https://microbadger.com/images/j33r/mopidy)
![GitHub Workflow Status (branch)](https://img.shields.io/github/actions/workflow/status/jee-r/docker-mopidy/deploy.yaml?branch=main&style=flat-square)
[![Docker Pulls](https://img.shields.io/docker/pulls/j33r/mopidy?style=flat-square)](https://hub.docker.com/r/j33r/mopidy)
[![DockerHub](https://img.shields.io/badge/Dockerhub-j33r/mopidy-%232496ED?logo=docker&style=flat-square)](https://hub.docker.com/r/j33r/mopidy)
[![ghcr.io](https://img.shields.io/badge/ghrc%2Eio-jee%2D-r/mopidy-%232496ED?logo=github&style=flat-square)](https://ghcr.io/jee-r/mopidy)


A docker image for [mopidy](https://mopidy.com/) based on [Alpine Linux](https://alpinelinux.org) and **[without root process](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user)**

## What is Mopidy :

From [mopidy.com](https://mopidy.com):

> Mopidy is an extensible music server written in Python.
>
> Mopidy plays music from local disk, Spotify, SoundCloud, TuneIn, and more. You can edit the playlist from any phone, tablet, or computer using a variety of MPD and web clients.

- Source code : https://github.com/mopidy/mopidy
- Documentation : https://docs.mopidy.com/en/latest/
- Official Website : https://mopidy.com

## How use this image :

### With Docker

```bash
docker run \
    --detach \
    --interactive \
    --name mopidy \
    --user $(id -u):$(id -g) \
    #--volume ./config:/config \
    --volume ./media:/media \
    --volume /etc/localtime:/etc/localtime:ro \
    --env TZ=Europe/Paris \
    --env HOME=/config \
    --publish 6600:6600 \
    --publish 6680:6680 \
    --publish 5555:5555/udp \
    j33r/mopidy:latest
```

Note: `--user $(id -u):$(id -g)` should work out of the box on linux systems. If your docker host run on windows or if you want specify an other user id and group id just replace with the appropriates values.   

### With Docker Compose

```yaml
version 3

services:
  mopidy:
    image: j33r/mopidy:latest
    container_name: mopidy
    restart: unless-stopped
    user: "1000:1000"
    volumes:
    #  - ./config:/config
    #  - ./media:/media
      - /etc/localtime:/etc/localtime:ro
    environments:
        - HOME=/config
        - TZ=Europe/Paris
    ports:
      - 6600:6600
      - 6680:6680
      - 5555:5555/udp
```

## Volumes

`/config`: If you mount this directory you must provide a `mopidy.conf` configuration file in it
`/media`: Directory where your media files are stored (mp3,flac,ogg...)

## Config

By default image is running mopidy with this [default config](rootfs/etc/default/mopidy.conf). 
When container start if `/config` directory is mounted and `/config/mopidy.conf` don't exist [`entrypoint.sh` script](rootfs/usr/local/bin/entrypoint.sh) will copy default config and create neccesary directories in it. 

## Environment variables

To change the timezone of the container set the `TZ` environment variable. The full list of available options can be found on [Wikipedia](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).

You can also set the `HOME` environment variable this is usefull to get in the right directory when you attach a shell in your docker container.

## Logs

Logs are available by running `docker logs mopidy`

# License

This project is under the [GNU Generic Public License v3](LICENSE) to allow free use while ensuring it stays open.

