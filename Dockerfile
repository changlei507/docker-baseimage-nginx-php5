FROM mhert/baseimage:0.1

MAINTAINER Mathias Hertlein

CMD ["/sbin/my_init"]

EXPOSE 80
EXPOSE 443

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN rm -rf /etc/service/sshd && \
    echo "deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx" > /etc/apt/sources.list.d/nginx.list && \
    echo "deb-src http://nginx.org/packages/mainline/ubuntu/ trusty nginx" > /etc/apt/sources.list.d/nginx.list && \
    curl http://nginx.org/keys/nginx_signing.key | apt-key add - && \
    apt-get update && \
    apt-get dist-upgrade -y --no-install-recommends && \
    apt-get install nginx php5-fpm -y && \
    apt-get clean && \
    sed -i -e "s/\/var\/log\/php5-fpm.log/\/var\/log\/php5\/fpm.log/g" /etc/php5/fpm/php-fpm.conf && \
    sed -i -e "s/;error_log = php_errors.log/error_log = \/var\/log\/php5\/php.log/g" /etc/php5/fpm/php.ini && \
    mkdir /var/log/php5 && \
    chown -R www-data:www-data /var/log/php5

ADD etc /etc
    
RUN chmod +x /etc/service/nginx/run  && \
    chmod +x /etc/service/php5-fpm/run && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -rf /etc/service/sshd

VOLUME ["/var/log/nginx", "/var/log/php5"]