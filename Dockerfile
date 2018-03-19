FROM ubuntu:16.04
MAINTAINER kp <dockerkp@gmail.com>


VOLUME /var/lib/rippled/db
VOLUME /opt/ripple/etc
VOLUME /var/log/rippled/

EXPOSE 51235

RUN apt-get update
RUN apt-get install -y yum-utils alien

RUN rpm -Uvh https://mirrors.ripple.com/ripple-repo-el7.rpm
RUN yumdownloader --enablerepo=ripple-stable --releasever=el7 rippled

RUN rpm --import https://mirrors.ripple.com/rpm/RPM-GPG-KEY-ripple-release && rpm -K rippled*.rpm
RUN alien -i --scripts rippled*.rpm && rm rippled*.rpm
CMD ["/opt/ripple/bin/rippled", "--net", "--conf", "/etc/opt/ripple/rippled.cfg"]
