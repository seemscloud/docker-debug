FROM alpine:latest

RUN apk update

RUN apk add bind-tools

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]