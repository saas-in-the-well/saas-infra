#!/bin/bash
set -e
kubectl delete namespace monitoring

kubectl create namespace monitoring

kubectl apply -f grafana.yaml --namespace=monitoring

