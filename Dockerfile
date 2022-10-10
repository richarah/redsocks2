FROM debian:bullseye

ENV DOCKER_NET docker0
ENV DEBIAN_FRONTEND noninteractive

# TODO: figure out how Redsocks user config works.
# (no documentation provided, and when compiling from source, necessary UID/GID magic is not set up)
WORKDIR /
RUN apt-get update
RUN apt-get install -y build-essential libevent-dev openssl libssl-dev iptables redsocks

ADD . /rs2
WORKDIR /rs2
COPY redsocks.conf /etc/redsocks.conf

# For compiling on newer systems
RUN make DISABLE_SHADOWSOCKS=true

CMD sh -c "cd /rs2 && exec ./redsocks2 -c redsocks.conf"
