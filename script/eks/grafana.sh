#!/bin/bash
set -e

kubectl create namespace monitoring

kubectl apply -f grafana.yaml --namespace=monitoring

