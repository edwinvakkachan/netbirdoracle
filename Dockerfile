FROM alpine:latest

RUN apk add --no-cache openssh-client

WORKDIR /app

COPY restart.sh /app/restart.sh

RUN chmod +x /app/restart.sh

CMD while true; do /app/restart.sh; sleep 300; done