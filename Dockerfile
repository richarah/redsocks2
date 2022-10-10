FROM debian:bullseye

ENV DOCKER_NET docker0
ENV DEBIAN_FRONTEND noninteractive

# TODO: figure out how Redsocks user config works.
# (no documentation provided, and when compiling from source, necessary UID/GID magic is not set up)
WORKDIR /
RUN apt-get update
RUN apt-get install -y build-essential libevent-dev openssl libssl-dev iptables redsocks zlib1g zlib1g-dev sudo

ADD . /rs2
WORKDIR /rs2

# Some confusion wrt. setup docs
COPY redsocks.conf /etc/redsocks.conf
COPY redsocks.conf /etc/redsocks.tmpl

RUN make ENABLE_STATIC=true

# Permissions
RUN usermod -aG sudo redsocks
RUN chmod +x redsocks2

CMD sh -c "cd /rs2 && exec ./redsocks2"
