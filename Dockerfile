FROM alpine:3.16

WORKDIR /
RUN apk update
RUN apk add alpine-sdk libevent libevent-dev openssl openssl-dev iptables iptables-dev nss nss-dev

ADD . /rs2
WORKDIR /rs2
COPY redsocks.conf /etc/redsocks.conf

# For compiling on newer systems
RUN make DISABLE_SHADOWSOCKS=true

# ENTRYPOINT ["./rs2/redsocks2 -c /etc/redsocks.conf"]
