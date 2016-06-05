FROM ubuntu:12.04

MAINTAINER Harin Jeon <junharin2@gmail.com> Sukhyun Seo <seosukhyun@gmail.com>
RUN apt-get update
RUN apt-get install -y build-essential autoconf automake libtool libcppunit-dev libevent-dev libxml2 libxml2-dev libpango1.0-dev libcairo2-dev libevent-dev tmux python2.7-dev vim sudo git net-tools npm python-pip python3-dev python3 python-setuptools python-dev python3-setuptools wget python-software-properties software-properties-common curl

RUN add-apt-repository ppa:fkrull/deadsnakes
RUN apt-get update
RUN apt-get install -y python3.4
RUN rm /usr/bin/python3
RUN ln -s /usr/bin/python3.4 /usr/bin/python3
RUN python3 --version

RUN adduser --disabled-password --gecos '' arcus
RUN adduser arcus sudo
RUN chown -R arcus:arcus /home/arcus

WORKDIR /home/arcus
RUN mkdir vendor

USER root
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
WORKDIR /home/arcus/vendor

ENV HOME /home/arcus

# rrdtool
RUN curl -OL http://oss.oetiker.ch/rrdtool/pub/rrdtool-1.4.8.tar.gz
RUN tar xvf rrdtool-1.4.8.tar.gz
WORKDIR /home/arcus/vendor/rrdtool-1.4.8
RUN ./configure --prefix=$HOME/arcus-collectd
RUN make; make install

WORKDIR /home/arcus/vendor

# collectd
RUN curl -OL https://collectd.org/files/collectd-5.4.1.tar.gz
RUN tar xvf collectd-5.4.1.tar.gz
WORKDIR /home/arcus/vendor/collectd-5.4.1
RUN ./configure --prefix=$HOME/arcus-collectd --enable-python --enable-rrdtool --with-librrd=$HOME/arcus-collectd
RUN make; make install

# sample website install
WORKDIR /home/arcus
ADD arcus_web /home/arcus/arcus_web

WORKDIR /home/arcus/vendor
RUN git clone https://github.com/naver/arcus-hubble.git
WORKDIR /home/arcus/vendor/arcus-hubble

RUN sed 's/"zookeeper": "\*"/"zookeeper": "3.4.1"/g' package.json >>new.json
RUN mv new.json package.json

RUN ./setup.sh

ADD clearun.sh /home/arcus/vendor/arcus-hubble/clearun.sh
RUN chmod 755 /home/arcus/vendor/arcus-hubble/clearun.sh

RUN chown -R arcus:arcus /home/arcus
CMD ["/bin/bash"]

