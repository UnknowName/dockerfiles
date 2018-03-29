#AUTHOR unknowname
#VERSION v1.0
#DATE 2018-03-29
# ENV openresty v1.13.6.1 OpenSSLv1.0.2K

FROM ubuntu:16.04
RUN apt-get update \
    && apt-get install wget -y \
    && wget -qO - https://openresty.org/package/pubkey.gpg | apt-key add - \
    && apt-get -y install software-properties-common \
    && add-apt-repository -y "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main" \
    && apt-get update
RUN  apt-get install openresty -y
EXPOSE 80 443
CMD ["openresty", "-g", "daemon off;"]
