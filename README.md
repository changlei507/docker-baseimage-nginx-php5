baseimage-nginx-php5
====================

A mhert/baseimage based Dockerfile for running nginx+php5

This is just the baseimage for application-containers.

``` shell
$ docker run -d --name nginx -p 80:80 -p 443:443 -v /tmp/nginx/log:/var/log/nginx -v /tmp/php/log:/var/log/php5 mhert/baseimage-nginx-php5:latest
```
