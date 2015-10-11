FROM debian:jessie

MAINTAINER Simeon Ackermann <ackermann@infai.org>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y cron

# Add our crontab file
# ADD crons.conf /root/crons.conf

# Use the crontab file
# RUN crontab /root/crons.conf

# Start cron
# RUN cron

ADD backup.sh /backup.sh
CMD ["/bin/bash", "/backup.sh"]