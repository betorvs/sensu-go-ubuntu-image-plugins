# sensu ubuntu agent for kubernetes

I created this simple container to test Kubernetes Clusters using sensu-plugin-kubernetes and for test from inside kubernetes cluster a desired http URL.

## Use:

```
$ ./test.sh REPOSITORY TAG
```

Access web interface in `localhost:3000` using default credentials for [sensu-backend](https://docs.sensu.io/sensu-go/5.5/reference/rbac/#default-user) and check the event there.

## To Clean the test:

```
./clean.sh
```

## Push the image

```
$ doker login REGISTRY
$ docker push REPOSITORY:TAG
```

## Use `deployment.yml` to create this server in KUBERNETES

Replace `env` in file and apply:
```
$ kubectl apply -f deployment.yml
```

## Special service

I enabled http local port as a service inside kubernetes:

- `sensu.sensu:3031`

To test inside kubernetes
```
$ kubectl run nginx-test --image=nginx
$ kubectl get pods
$ kubectl exec -ti nginx-test-XXX-YY bash
$ apt-get update && apt-get install curl
$ curl -X POST \
-H 'Content-Type: application/json' \
-d '{
  "check": {
    "metadata": {
      "name": "check-container-alive"
    },
    "status": 0,
    "output": "nginx-test say hello"
  }
}' \
http://sensu.sensu:3031/events
```
