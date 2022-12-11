FROM alpine:latest

RUN apk update && \
    apk add bash

SHELL ["/bin/bash", "-c"]

RUN apk add bind-tools

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]