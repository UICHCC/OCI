FROM ubuntu:22.04
MAINTAINER "Terence Lau" <me@cklau.cc>

# Change Mirrors

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
openconnect ocproxy \
&& apt-get update \
&& apt-get upgrade -y \
&& apt-get remove -fy \
&& apt-get autoclean -y \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# Setup openconnect proxy entrypoint
COPY proxy.sh /usr/local/bin/proxies
RUN ["chmod", "+x", "/usr/local/bin/proxies"]
ENTRYPOINT ["/usr/local/bin/proxies"]

EXPOSE 9052
