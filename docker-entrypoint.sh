#!/bin/bash
set -e

exec /usr/sbin/sensu-agent start --api-host 0.0.0.0 --name $SENSU_AGENT_NAME --namespace $SENSU_NAMESPACE --subscriptions $SENSU_SUBSCRIPTIONS --backend-url $SENSU_BACKEND_URL --log-level $SENSU_LOGLEVEL
