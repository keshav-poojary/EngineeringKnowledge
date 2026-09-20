# Kubernetes Examples

This folder contains small Kubernetes examples for a Node.js application, MongoDB, configuration, and persistent storage.

## Prerequisites

- A working Kubernetes cluster and `kubectl`
- Access to the `philippaul/node-mongo-db:04` container image

Check the active cluster before applying anything:

```bash
kubectl config current-context
kubectl get nodes
```

## Apply the application

Apply the storage resources and MongoDB first, then the application configuration and deployment:

```bash
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml
kubectl apply -f mongo.yaml
kubectl apply -f config.yaml
kubectl apply -f app.yaml
```

The application is exposed through a `LoadBalancer` service on port 80. MongoDB is exposed internally through the `service-mongo-app` service.

Inspect the deployment and services with:

```bash
kubectl get pods,svc,pvc
kubectl describe deployment app-node
```

`pod.yaml` is a separate nginx volume-mount example using the `my-pvc` claim. Apply it independently when you want to test that example:

```bash
kubectl apply -f pod.yaml
```

## Remove the examples

```bash
kubectl delete -f app.yaml
kubectl delete -f config.yaml
kubectl delete -f mongo.yaml
kubectl delete -f pod.yaml
kubectl delete -f pvc.yaml
kubectl delete -f pv.yaml
```

Review manifests before applying them to a shared or production cluster.
