# Start from Alpine Linux
FROM alpine:3.18

# Build args
ARG UID=1000
ARG GID=1000

# Add packages
RUN apk add --no-cache supervisor
RUN apk add --no-cache collectd collectd-disk collectd-exec collectd-network collectd-sensors
RUN apk add --no-cache telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
RUN apk add --no-cache radeontop bash
#RUN apk add --no-cache build-base cpupower lm-sensors lm-sensors-dev

# Add user
RUN addgroup -g $GID user
RUN adduser -s /sbin/nologin -G user -D -u $UID user

# Create config files
RUN chgrp user /run 
RUN chmod g+w /run
RUN mkdir -p /opt/collectd
RUN chown user:user /opt/collectd
COPY ./app /app
COPY ./app/etc /etc

# Drop root
USER user

# Build collectd
#WORKDIR /tmp
#ADD --chmod=0644 --chown=user:user https://storage.googleapis.com/collectd-tarballs/collectd-5.12.0.tar.bz2 /tmp
#RUN tar xvfj collectd-5.12.0.tar.bz2 
#WORKDIR /tmp/collectd-5.12.0
#RUN ./configure --prefix=/opt/collectd --disable-netlink --disable-tcpconns --disable-wireless
#RUN make all
#RUN make install
#WORKDIR /opt/collectd
#RUN rm -rf /tmp/collectd*

# Start supervisor
CMD supervisord
