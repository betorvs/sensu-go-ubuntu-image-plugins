#!/bin/bash

docker stop sensu-backend
docker rm sensu-backend
docker stop sensu-agent-test
docker rm sensu-agent-test
