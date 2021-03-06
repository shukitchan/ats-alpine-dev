FROM alpine:3.14.6

RUN apk add --no-cache --virtual .tools \
  bzip2 curl git automake libtool autoconf make \
  sed file perl openrc openssl sudo su-exec

RUN apk add --no-cache --virtual .ats-build-deps \
  build-base openssl-dev tcl-dev pcre-dev zlib-dev \
  libexecinfo-dev linux-headers libunwind-dev \
  brotli-dev jansson-dev luajit-dev readline-dev \
  geoip-dev

RUN apk add --no-cache --virtual .ats-extra-build-deps --repository https://dl-cdn.alpinelinux.org/alpine/edge/community hwloc-dev

# essential library
RUN apk add --no-cache -U \
  bash build-base curl ca-certificates pcre \
  zlib openssl brotli jansson luajit libunwind \
  readline geoip libexecinfo tcl openrc

RUN apk add --no-cache -U --repository https://dl-cdn.alpinelinux.org/alpine/edge/community hwloc

# download and build ATS
RUN curl -L https://downloads.apache.org/trafficserver/trafficserver-9.1.2.tar.bz2 | bzip2 -dc | tar xf - \
  && cd trafficserver-9.1.2/ \
  && autoreconf -if \
  && ./configure --enable-debug=yes \
  && make \
  && make install

# enable traffic.out for alpine/gentoo
RUN sed -i "s/TM_DAEMON_ARGS=\"\"/TM_DAEMON_ARGS=\" --bind_stdout \/usr\/local\/var\/log\/trafficserver\/traffic.out --bind_stderr \/usr\/local\/var\/log\/trafficserver\/traffic.out \"/" /usr/local/bin/trafficserver
RUN sed -i "s/TS_DAEMON_ARGS=\"\"/TS_DAEMON_ARGS=\" --bind_stdout \/usr\/local\/var\/log\/trafficserver\/traffic.out --bind_stderr \/usr\/local\/var\/log\/trafficserver\/traffic.out \"/" /usr/local/bin/trafficserver

# entry.sh
COPY ["./entry.alpine.sh", "/usr/local/bin/entry.sh"]
WORKDIR /usr/local/bin/
RUN chmod 755 entry.sh

ENTRYPOINT ["/usr/local/bin/entry.sh"] 
