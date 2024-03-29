#!/bin/bash

docker run --rm {{ container_image }}:{{ container_tag }} bash -c " \
  for QUEUE in {{ item.cron_queues }}; do \
    /khronos/bin/cli.js --queue \$QUEUE --job '{}' --host {{ cron_rabbit_host_address }} {{ cron_rabbit_auth }}; \
  done"
