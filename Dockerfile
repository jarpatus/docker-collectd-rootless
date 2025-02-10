# Start from Alpine Linux
FROM alpine:3.18

# Add packages
RUN apk add --no-cache collectd collectd-disk collectd-network collectd-sensors lm-sensors supervisor
RUN apk add --no-cache telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

# Add user
RUN addgroup -g $GID user
RUN adduser -s /sbin/nologin -G user -D -u $UID user

# Create config files
RUN chgrp user /run
RUN chmod g+w /run
RUN mkdir -p /var/lib/collectd
RUN chown user:user /var/lib/collectd
COPY ./app/etc /etc

# Drop root
USER user

# Start supervisor
CMD supervisord
