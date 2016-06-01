FROM ubuntu:14.04

MAINTAINER Harin Jeon <junharin2@gmail.com> Sukhyun Seo <seosukhyun@gmail.com>

# presettings
RUN apt-get update
RUN apt-get install -y build-essential autoconf automake libtool libcppunit-dev python-setuptools python-dev openjdk-7-jdk libevent-dev git curl vim sudo ant

# add user
RUN adduser --disabled-password --gecos '' arcus
RUN adduser arcus sudo

# clone arcus
WORKDIR /home/arcus
RUN git clone https://github.com/naver/arcus.git

# build arcus
WORKDIR /home/arcus/arcus/scripts
RUN ./build.sh

# zookeeper settings
WORKDIR /home/arcus/arcus/zookeeper
RUN ant compile_jute
WORKDIR /home/arcus/arcus/zookeeper/src/c
RUN autoreconf -if
RUN ./configure --prefix=/home/arcus/arcus
RUN make && make install

# memcached & zookeeper settings
WORKDIR /home/arcus/arcus/server
RUN ./config/autorun.sh
RUN ./configure --with-libevent=/home/arcus/arcus
RUN make && make install

## hubblemon install
RUN apt-get install -y build-essential python3 python3-dev python3-pip rrdtool librrd-dev
RUN pip3 install django psutil kazoo rrdtool

# clone hubblemon
WORKDIR /home/arcus
RUN git clone https://github.com/naver/hubblemon.git
ADD patch.patch /home/arcus/patch.patch

# edit common settings
WORKDIR /home/arcus/hubblemon
RUN patch -f -p1 < /home/arcus/patch.patch # patch

# add clearun scripts
ADD clearun_hubblemon.sh /home/arcus/hubblemon/clearun_hubblemon.sh
ADD clearun_arcus.sh /home/arcus/arcus/scripts/clearun_arcus.sh
#ADD install_ngrinder.sh /home/arcus/install_ngrinder.sh

# install python clients
RUN mkdir /home/arcus/test
WORKDIR /home/arcus/test
RUN git clone https://github.com/naver/arcus-python-client

# test web
RUN apt-get install -y python-pip python-mysqldb
RUN pip3 install django virtualenv
ADD arcus_web /home/arcus/test/arcus_web


# install ngrinder
#RUN apt-get install -y wget aptitude # tomcat7 oracle-jdk7-installer
#RUN aptitude install -y software-properties-common
#RUN add-apt-repository ppa:webupd8team/java
#RUN apt-get update
#RUN apt-get install -y oracle-jdk7-installer
#RUN apt-get install -y tomcat7
#RUN chown tomcat7:tomcat7 /usr/share/tomcat7
#RUN sed -i "1s/^JAVA_OPTS='-Xms600m -Xmx1024m -XX:MaxPermSize=200m'\n/" /usr/share/tomcat7/bin/catalina.sh
#WORKDIR /var/lib/tomcat7/webapps/
#RUN wget https://github.com/downloads/nhnopensource/ngrinder/ngrinder-controller-3.0.4.war
#sed -i "1s/^JAVA_HOME=$(readlink -f /usr/bin/java | sed 's:bin/java::')/" /etc/default/tomcat7
#RUN apt-get update
#RUN apt-get install oracle-jdk7-installer tomcat7

# chown
RUN chown -R arcus:arcus /home/arcus
USER arcus

# run arcus
WORKDIR /home/arcus/arcus/scripts
#CMD ["/bin/bash"]
#RUN service tomcat7 start
CMD ["/bin/bash", "/home/arcus/arcus/scripts/clearun_arcus.sh"]
