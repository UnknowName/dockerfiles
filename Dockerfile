FROM debian:10
ENV TZ=Asia/Shanghai

RUN export VERSION=1.10.5
    && apt-get update \
    && apt-get install -y wget subversion  gnupg2 wget lsb-release \ 
    && wget https://files.freeswitch.org/repo/deb/debian-release/fsstretch-archive-keyring.asc \
    && apt-key add fsstretch-archive-keyring.asc \
    && echo "deb http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" > /etc/apt/sources.list.d/fs.list \
    && echo "deb-src http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" >> /etc/apt/sources.list.d/fs.list \
    && apt-get update \
    # apt-cache search PackageName
    && wget https://files.freeswitch.org/releases/freeswitch/freeswitch-${VERSION}.-release.tar.gz \
    && apt-get -y build-dep freeswitch \
    && tar -zxvf freeswitch-${VERSION}.-release.tar.gz -C /usr/src \
    && rm -rf freeswitch-${VERSION}.-release.tar.gz \
    && cd /usr/src/freeswitch-${VERSION}.-release \
    && ./configure --enable-optimization --enable-64 --enable-core-odbc-support --enable-optimization --with-odbc  --prefix=/opt/freeswitch \
    && make \
    && make install \
    && make cd-sounds-install \
    && rm -rf  /usr/src/freeswitch-${VERSION}.-release \
    && apt-get clean
