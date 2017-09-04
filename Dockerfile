FROM nginx:1.13

COPY ./package/ /usr/local/bin/
RUN chmod +x /usr/local/bin/confd
RUN mkdir -p /etc/confd/{conf.d,templates}

COPY ./shell/run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/run.sh

RUN apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y logrotate cron\
    && rm -rf /var/lib/apt/lists/*

EXPOSE 80 443

CMD ["/usr/local/bin/run.sh"]