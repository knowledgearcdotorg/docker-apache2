FROM ubuntu:16.04
MAINTAINER development@knowledgearc.com

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update

RUN apt-get upgrade -y && \
    apt-get install -y apache2 supervisor && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor

RUN a2enmod ssl
RUN a2enmod proxy_fcgi

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
