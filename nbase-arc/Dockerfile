FROM ubuntu:12.04

MAINTAINER HARIN JEON <junharin2@gmail.com> Sukhyun Seo <seosukhyun@gmail.com>

RUN apt-get update
RUN apt-get install -y default-jdk vim sudo git wget build-essential curl autoconf python-pip python-dev

WORKDIR $WORKSPACE
RUN git clone https://github.com/naver/nbase-arc.git
WORKDIR nbase-arc
RUN make release
RUN cp -r release/nbase-arc $HOME
RUN apt-get install -y zookeeper
RUN service zookeeper-server init
RUN service zookeeper-server start
WORKDIR $HOME/nbase-arc/confmaster

RUN sed 's/confmaster.ip=0.0.0.0/confmaster.ip=127.0.0.1/g' cc.properties >> cc.properties_back
RUN mv cc.properties_back cc.properties
RUN sed 's/confmaster.zookeeper.address=127.0.0.1:2181/confmaster.zookeeper.address=127.0.0.1:2184/g' cc.properties >> cc.properties_back
RUN mv cc.properties_back cc.properties

RUN cd $HOME/nbase-arc/confmaster
RUN ./confmaster-v1.2.5-46-gda25ff0.sh

RUN pip install fabric
RUN cd $HOME/nbase-arc/mgmt/config
RUN sed 's/CONF_MASTER_IP = None/CONF_MASTER_IP = "127.0.0.1"/g' conf_mnode.py >> conf_mnode.py_back
RUN mv conf_mnode.py_back conf_mnode.py
RUN sed 's/CONF_MASTER_PORT = None/CONF_MASTER_PORT = 1122/g' conf_mnode.py >> conf_mnode.py_back
RUN mv conf_mnode.py_back conf_mnode.py
RUN sed 's/CONF_MASTER_MGMT_CONS = 3/CONF_MASTER_MGMT_CONS = 1/g' conf_mnode.py >> conf_mnode.py_back
RUN mv conf_mnode.py_back conf_mnode.py
RUN sed 's/USERNAME = None/ USERNAME = "root"/g' conf_mnode.py >> conf_mnode.py_back
RUN mv conf_mnode.py_back conf_mnode.py

