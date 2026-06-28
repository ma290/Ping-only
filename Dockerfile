FROM alpine:latest

RUN apk add --no-cache curl bash

WORKDIR /app

COPY ping.sh .
RUN chmod +x ping.sh

CMD ["./ping.sh"]
