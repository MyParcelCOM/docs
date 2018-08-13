FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y curl git \
    && curl -o hugo.deb -L https://github.com/gohugoio/hugo/releases/download/v0.46/hugo_0.46_Linux-64bit.deb \
    && dpkg -i hugo.deb \
    && rm hugo.deb \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 1313
