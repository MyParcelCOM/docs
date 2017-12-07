FROM ubuntu:16.04

LABEL author="Sam de Vries <sam@myparcel.com>"

ARG HUGO_VERSION

RUN apt-get update \
    && apt-get install -y curl git \
    && curl -o hugo.deb -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.deb \
    && dpkg -i hugo.deb \
    && rm hugo.deb \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 1313

CMD hugo server --bind 0.0.0.0