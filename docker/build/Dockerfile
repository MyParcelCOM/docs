FROM ubuntu:18.04 as build

ARG DOMAIN="docs.myparcel.com"

RUN apt-get update \
    && apt-get install -y curl git \
    && curl -o hugo.deb -L https://github.com/gohugoio/hugo/releases/download/v0.54.0/hugo_0.54.0_Linux-64bit.deb \
    && dpkg -i hugo.deb \
    && rm hugo.deb \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt/hugo

RUN mkdir -p themes \
    && cd themes \
    && rm -rf hugo-theme-docdock \
    && git clone https://github.com/vjeantet/hugo-theme-docdock.git \
    && cd hugo-theme-docdock \
    && git checkout tags/v1.1

ADD . /opt/hugo

RUN hugo --baseURL "https://${DOMAIN}/"

FROM nginx:1.16-alpine

COPY --from=build /opt/hugo/public /usr/share/nginx/html

ADD ./docker/build/default.conf /etc/nginx/conf.d/default.conf
