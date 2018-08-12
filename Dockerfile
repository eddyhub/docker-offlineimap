FROM alpine:3.8

RUN apk add --no-cache offlineimap
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
