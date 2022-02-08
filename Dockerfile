FROM ubuntu:latest as builder

WORKDIR /work

RUN apt-get update -y 
RUN apt-get install -y curl
RUN curl -s https://install.speedtest.net/app/cli/install.deb.sh | bash
RUN apt-get install -y speedtest

FROM scratch
COPY --from=builder /usr/bin/speedtest /speedtest
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

ENTRYPOINT [ "/speedtest" ]
