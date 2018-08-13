FROM siriuszg/nginx-ingress-controller:0.17.1

USER root

RUN apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y redhat-lsb logrotate cron \
    && rm -rf /var/lib/apt/lists/* && update-rc.d cron defaults && update-rc.d cron enable

# Clear cron daily
RUN rm /etc/cron.daily/*

COPY ./config/cron/crontab /etc/crontab
COPY ./config/cron/cron.daily/ /etc/cron.daily/
COPY ./config/logrotate/nginx /etc/logrotate.d/nginx