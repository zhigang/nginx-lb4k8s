FROM nginx:1.13

RUN apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y logrotate cron anacron\
    && rm -rf /var/lib/apt/lists/*

COPY ./package/ /usr/local/bin/
RUN chmod +x /usr/local/bin/confd
RUN mkdir -p /etc/confd/{conf.d,templates}

COPY ./config/cron/crontab /etc/crontab
COPY ./config/logrotate/nginx /etc/logrotate.d/nginx
COPY ./config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./config/confd/nginx.toml /etc/confd/conf.d/nginx.toml
COPY ./config/confd/templates/nginx.tmpl /etc/confd/templates/nginx.tmpl

COPY ./shell/run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/run.sh

EXPOSE 80 443

CMD ["/usr/local/bin/run.sh"]