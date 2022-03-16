Docker Image for Development Environment for Apache Traffic Server (ATS) 9.1.2 on alpine 3.14.3
====
 - http://trafficserver.apache.org/

Instructions to Manually Build the Image
====
 - `git clone https://github.com/shukitchan/ats-alpine-dev.git`
 - `cd ats-alpine-dev`
 - `docker build -f Dockerfile -t ats-alpine-dev .`
 - `docker run -it ats-alpine-dev`

Compile and Deploy ATS
====
 - `cd /trafficserver-9.1.2`
 - `./configure`
 - `make`
 - `make install`

Stop/Start/Restart ATS
====
 - To stop, `DISTRIB_ID=gentoo /usr/local/bin/trafficserver stop`
 - To start, `DISTRIB_ID=gentoo /usr/local/bin/trafficserver start`
 - To restart, `DISTRIB_ID=gentoo /usr/local/bin/trafficserver restart`
