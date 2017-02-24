#AUTHOR unknowname
#VERSION 1.0
#CREATE_DATE 2017-02-24 


FROM nginx:1.9
RUN apt-get update&&apt-get install curl unzip -y
ENV CONSUL_TEMPLATE_URL https://releases.hashicorp.com/consul-template/0.18.1/consul-template_0.18.1_linux_amd64.zip
RUN cd /usr/local/sbin&&curl $CONSUL_TEMPLATE_URL>consul-template.zip&&unzip consul-template.zip
WORKDIR /usr/local/sbin
ADD nginx.tmp  /tmp/nginx.tmp
RUN chmod +x /usr/local/sbin/*
ENV CONSUL_ADDR 192.168.0.12:8500
VOLUME  [/usr/sbin/nginx,/etc/nginx/nginx.conf]
CMD consul-template -template "/tmp/nginx.tmp:/etc/nginx/nginx.conf:/usr/sbin/service nginx restart" -consul-addr=$CONSUL_ADDR
