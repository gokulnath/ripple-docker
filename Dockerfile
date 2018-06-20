FROM ubuntu:18.04
MAINTAINER kp <dockerkp@gmail.com>


VOLUME /var/lib/rippled/db
VOLUME /opt/ripple/etc
VOLUME /var/log/rippled/

EXPOSE 5123
RUN mkdir -p /opt/ripple/bin/
RUN apt-get update; apt-get -y upgrade  &&  \
apt-get -y install git &&  \
apt-get -y install pkg-config &&  \
apt-get -y install protobuf-compiler &&  \ 
apt-get -y install libprotobuf-dev &&  \
apt-get -y install libssl-dev &&  \
apt-get  -y  install libboost-all-dev && \
apt-get clean

RUN git clone https://github.com/ripple/rippled.git --depth 1 -b 1.0.1  &&  \
cd rippled && \
mkdir build && \
cd build && \
cmake -Dtarget=gcc.debug.unity .. &&\
cd .. && \
build/rippled -u && \
cp -r build/rippled /opt/ripple/bin/  && \
rm -rf ../rippled
CMD ["/opt/ripple/bin/rippled", "--net", "--conf", "/opt/ripple/etc/rippled.cfg"]
