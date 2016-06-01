FROM ubuntu:14.04

MAINTAINER Harin Jeon <junharin2@gmail.com> Sukhyun Seo <seosukhyun@gmail.com>

# presettings
RUN apt-get update
RUN apt-get install -y build-essential python3 python3-dev python3-pip rrdtool librrd-dev git sudo vim

# add user
RUN adduser --disabled-password --gecos '' hubblemon
RUN adduser hubblemon sudo

RUN pip3 install django psutil kazoo rrdtool

# clone hubblemon
WORKDIR /home/hubblemon
RUN git clone https://github.com/naver/hubblemon.git
ADD patch.patch /home/hubblemon/patch.patch

# edit common settings
WORKDIR /home/hubblemon/hubblemon
RUN patch -f -p1 < /home/hubblemon/patch.patch # patch
ADD clearun.sh /home/hubblemon/hubblemon/clearun.sh

# chown
RUN chown -R hubblemon:hubblemon /home/hubblemon
USER hubblemon

# run hubblemon
WORKDIR /home/hubblemon/hubblemon
#CMD ["/bin/bash"]
CMD ["/bin/bash", "clearun.sh"]
