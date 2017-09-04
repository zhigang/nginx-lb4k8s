FROM nginx:1.13

RUN apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y logrotate cron\
    && rm -rf /var/lib/apt/lists/*

EXPOSE 80 443

CMD ["/usr/local/bin/run.sh"]