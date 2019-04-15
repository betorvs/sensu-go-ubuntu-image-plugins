#!/bin/bash

REPOSITORY="$1"
TAG="$2"


docker run -d --name sensu-backend -p 2380:2380 \
-p 3000:3000 -p 8080:8080 -p 8081:8081 sensu/sensu:latest sensu-backend start

docker build --no-cache -t ${REPOSITORY}:${TAG} -f Dockerfile .

docker run -d --name sensu-agent-test -p 3031:3031 -e SENSU_AGENT_NAME=sensu-agent-test -e SENSU_LOGLEVEL=debug -e SENSU_NAMESPACE=default -e SENSU_SUBSCRIPTIONS=test -e SENSU_BACKEND_URL="ws://sensu-backend:8081" --link sensu-backend:sensu-backend ${REPOSITORY}:${TAG}

echo "sleeping 5 seconds"

sleep 5

curl -X POST \
-H 'Content-Type: application/json' \
-d '{
  "check": {
    "metadata": {
      "name": "check-container-alive"
    },
    "status": 0,
    "output": "sensu.sensu service say hello"
  }
}' \
http://localhost:3031/events
