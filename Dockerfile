FROM ubuntu:18.04
MAINTAINER kp <dockerkp@gmail.com>


VOLUME /var/lib/rippled/db
VOLUME /opt/ripple/etc
VOLUME /var/log/rippled/

EXPOSE 5123
RUN mkdir -p /opt/ripple/bin/
RUN apt-get update; apt-get -y upgrade  &&  \
apt-get -y install git cmake pkg-config protobuf-compiler libprotobuf-dev libssl-dev cmake wget && \
apt-get clean

RUN cd /home && wget -nv http://downloads.sourceforge.net/project/boost/boost/1.67.0/boost_1_67_0.tar.gz \
  && tar xfz boost_1_67_0.tar.gz \
  && rm boost_1_67_0.tar.gz \
  && cd boost_1_67_0 \
  && ./bootstrap.sh \
  && ./b2 -j 8 \
  && cd /home

RUN git clone https://github.com/ripple/rippled.git --depth 1 -b 1.1.0  &&  \
  && cd rippled \
  && mkdir build \
  && cd build \
  && cmake -DBoost_DEBUG=true -DBOOST_ROOT=/home/boost_1_67_0 .. \
  && cmake --build . -- -j 4 \
  && cd .. \
  && build/rippled -u && \
cp -r build/rippled /opt/ripple/bin/  && \
rm -rf ../rippled
CMD ["/opt/ripple/bin/rippled", "--net", "--conf", "/opt/ripple/etc/rippled.cfg"]
