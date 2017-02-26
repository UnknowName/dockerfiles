#AUTHOR unknowname
#VERSION 1.0
#CREATE_DATE 2017-02-24 


FROM nginx:1.9
RUN apt-get update&&apt-get install curl unzip -y
ENV CONSUL_TEMPLATE_URL https://releases.hashicorp.com/consul-template/0.18.1/consul-template_0.18.1_linux_amd64.zip
RUN cd /usr/local/sbin&&curl $CONSUL_TEMPLATE_URL>consul-template.zip&&unzip consul-template.zip
WORKDIR /usr/local/sbin
ADD app.tmp  /tmp/app.tmp
ADD reloadNginx.sh /tmp
RUN chmod +x /usr/local/sbin/*
ENV CONSUL_ADDR 192.168.0.12:8500
CMD consul-template -template "/tmp/app.tmp:/etc/nginx/conf.d/app.conf:/bin/sh /tmp/reloadNginx.sh" -consul-addr=$CONSUL_ADDR
