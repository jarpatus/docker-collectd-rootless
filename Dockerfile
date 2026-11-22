# Start from Alpine Linux
FROM alpine:latest

# Build args
ARG UID=3830
ARG GID=3830

# Add packages
RUN apk add --no-cache supervisor
RUN apk add --no-cache collectd collectd-disk collectd-exec collectd-network collectd-sensors
RUN apk add --no-cache telegraf
RUN apk add --no-cache radeontop bash

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

# Start supervisor
CMD ["supervisord"]
