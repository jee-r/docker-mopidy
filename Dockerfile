FROM alpine:3.14

LABEL name="docker-mopidy" \
      maintainer="Jee jee@jeer.fr" \
      description="Mopidy is an extensible music server written in Python." \
      url="https://mopidy.com" \
      org.label-schema.vcs-url="https://github.com/jee-r/docker-mopidy"

COPY rootfs /

RUN apk update && \
    apk upgrade && \
    apk add --upgrade --no-cache --virtual=build-dependencies \
        gcc && \
    apk add --upgrade --no-cache --virtual=base \
        python3 \
        python3-dev \
        py3-pip \
        py3-gst \
        py3-six\
        py3-asn1 \
        py3-requests \
        py3-cryptography \
        py3-openssl \
        gstreamer \
        gstreamer-tools \
        gst-plugins-base \
        gst-plugins-good \
        gst-plugins-ugly && \
    pip3 install --upgrade --no-cache-dir \
        mopidy \
        Mopidy-Local \
        Mopidy-MPD \
        #mopidy-spotify \
        #git+https://github.com/sapristi/mopidy-mowecl.git \
        Mopidy-Mowecl==0.4.0 \
        Mopidy-Iris \
        Mopidy-Subidy \
        mopidy-funkwhale \
        Mopidy-Jamendo \
        Mopidy-Podcast \
        Mopidy-YouTube && \
    chmod +x /usr/local/bin/entrypoint.sh && \
    apk del --purge build-dependencies && \
    rm -rf /tmp/* 

WORKDIR /config

EXPOSE 6600 6680 5555/udp

STOPSIGNAL SIGQUIT
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
