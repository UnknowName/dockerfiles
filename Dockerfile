FROM debian:10
ENV TZ=Asia/Shanghai

RUN echo "start" \
    #sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list \
    # && sed -i "s/security.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list \  
    && apt-get clean \
    && apt-get update \
    && apt-get install -y wget subversion  gnupg2 wget lsb-release \ 
    && wget https://files.freeswitch.org/repo/deb/debian-release/fsstretch-archive-keyring.asc \
    && apt-key add fsstretch-archive-keyring.asc \
    && echo "deb http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" > /etc/apt/sources.list.d/fs.list \
    && echo "deb-src http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" >> /etc/apt/sources.list.d/fs.list \
    && apt-get update \
    # apt-cache search PackageName
    && wget https://files.freeswitch.org/releases/freeswitch/freeswitch-1.0.0.tar.gz \
    && apt-get -y build-dep freeswitch \
    && tar -zxvf freeswitch-1.0.0.tar.gz -C /usr/src \
    && cd /usr/src/freeswitch-1.0.0 \
    && ./configure --enable-optimization --enable-64 --enable-core-odbc-support \
    && make \
    && make install 
