FROM ubuntu:18.04
MAINTAINER kp <dockerkp@gmail.com>


VOLUME /var/lib/rippled/db
VOLUME /opt/ripple/etc
VOLUME /var/log/rippled/

EXPOSE 5123
RUN apt-get update; apt-get -y upgrade ; apt-get install -y software-properties-common
RUN apt-get -y install git &&  \
apt-get -y install scons &&  \
apt-get -y install pkg-config &&  \
apt-get -y install protobuf-compiler &&  \ 
apt-get -y install libprotobuf-dev &&  \
apt-get -y install libssl-dev 
RUN apt-get  -y  install libboost-all-dev
WORKDIR rippled
RUN git clone https://github.com/ripple/rippled.git .
RUN git checkout tags/0.90.1
RUN export SCONSFLAGS="-j `grep -c processor /proc/cpuinfo`"
RUN scons
RUN build/rippled -u
CMD ["build/rippled", "--net", "--conf", "/etc/opt/ripple/rippled.cfg"]
