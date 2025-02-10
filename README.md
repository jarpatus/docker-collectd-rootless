Ultra simple collectd + telegraf container which can push metrics e.g. to influxdb.

# Configuration 

## docker-compose.yaml

Example expects external network influxdb to exist so that container can connect to the database. 

```
services:
  collectd:
    container_name: collectd
    build:
      context: src
    restart: always
    environment:
      - UID=3830
      - GID=3830
    volumes:
      - ./config/etc/telegraf/telegraf.d/influxdb.conf:/etc/telegraf/telegraf.d/influxdb.conf
      - /proc:/mnt/proc:ro
    networks:
      influxdb:

networks:
  influxdb:
    name: influxdb
    external: true
```

## config/etc/telegraf/telegraf.d/influxdb.conf

For the example you will need authentication token, organization id and pre-existing collectd bucket. Please check influxdb documentation how to get / do these.

```
[[outputs.influxdb_v2]]
  urls = ["http://influxdb:8086"]
  token = "xxx"
  organization = "xxx"
  bucket = "collectd"

  [outputs.influxdb_v2.tagpass]
    bucket = ["collectd"]
```
