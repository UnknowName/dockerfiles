FROM debian:10
ENV TZ=Asia/Shanghai

RUN export VERSION=1.10.5 \
    && apt-get clean \
    && apt-get update \
    && apt-get install -y wget  unixodbc subversion gnupg2 wget lsb-release \ 
    && wget https://files.freeswitch.org/repo/deb/debian-release/fsstretch-archive-keyring.asc \
    && apt-key add fsstretch-archive-keyring.asc \
    && rm -rf fsstretch-archive-keyring.asc \
    # Add FreeSWITCH apt
    && echo "deb http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" > /etc/apt/sources.list.d/fs.list \
    && echo "deb-src http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" >> /etc/apt/sources.list.d/fs.list \
    && apt-get clean \
    && apt-get update \
    && apt-get -y build-dep freeswitch \
    # apt-cache search PackageName
    && wget https://files.freeswitch.org/releases/freeswitch/freeswitch-${VERSION}.-release.tar.gz \
    # ODBC MySQL Support
    && echo "deb http://ftp.de.debian.org/debian sid main" >> /etc/apt/sources.list.d/mysql.list \
    && echo "deb http://security.debian.org/debian-security jessie/updates main" >> /etc/apt/sources.list.d/mysql.list \
    && apt-get clean \
    && apt-get update \
    && apt-get install -y libmyodbc lua5.1 freeswitch-mod-lua  freeswitch-mod-expr \
    && tar -zxvf freeswitch-${VERSION}.-release.tar.gz -C /usr/src \
    && rm -rf freeswitch-${VERSION}.-release.tar.gz \
    && cd /usr/src/freeswitch-${VERSION}.-release \
    && ./configure --enable-optimization --enable-64 --enable-core-odbc-support --with-odbc --prefix=/usr/local/freeswitch \
    && make \
    && make install \
    && make cd-sounds-install \
    && ln -s /usr/local/freeswitch/bin/freeswitch  /usr/bin/freeswitch \
    && ln -s /usr/local/freeswitch/bin/fs_cli      /usr/bin/fs_cli \
    && ln -s /usr/local/freeswitch/etc/freeswitch  /etc/freeswitch \
    # Disable IPv6
    && mv /etc/freeswitch/sip_profiles/external-ipv6.xml /etc/freeswitch/sip_profiles/external-ipv6.xml.bak \
    && mv /etc/freeswitch/sip_profiles/internal-ipv6.xml /etc/freeswitch/sip_profiles/internal-ipv6.xml.bak \
    && sed -i "s/::/0.0.0.0/g" /etc/freeswitch/autoload_configs/event_socket.conf.xml \
    && rm -rf  /usr/src/freeswitch-${VERSION}.-release \
    && apt-get clean
ADD ./freeswitch/docker-entrypoint.sh /
ENTRYPOINT ["sh", "/docker-entrypoint.sh"]
CMD ["freeswitch"]