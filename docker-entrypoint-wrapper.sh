#!/bin/bash

set -e

if [ -n "RABBITMQ_APP_USER" ]; then
  (
  count=0;
  # Execute list_users until service is up and running
  until timeout 5 rabbitmqctl list_users >/dev/null 2>/dev/null || (( count++ >= 60 )); do sleep 1; done;
  if rabbitmqctl list_users | grep ${RABBITMQ_APP_USER} > /dev/null
  then
    rabbitmqctl change_password ${RABBITMQ_APP_USER} "${RABBITMQ_APP_PASS}"
    echo "already setup, password set"
  else
    rabbitmqctl add_user ${RABBITMQ_APP_USER} "${RABBITMQ_APP_PASS}"
    rabbitmqctl set_user_tags ${RABBITMQ_APP_USER} monitoring
    rabbitmqctl set_permissions -p / ${RABBITMQ_APP_USER}  ".*" ".*" ".*"
    echo "setup completed"
  fi
  ) &
fi

# Call original entrypoint
exec docker-entrypoint.sh rabbitmq-server $@
