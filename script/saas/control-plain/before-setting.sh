#!/bin/bash
set -e

# management에 필요한 namespace 생성
echo "Creating namespaces..."
kubectl create namespace manage
kubectl create namespace argocd
kubectl create namespace monitoring
kubectl create namespace cert-manager

kubectl label namespace manage group=management
kubectl label namespace argocd group=management
kubectl label namespace monitoring group=management
kubectl label namespace cert-manager group=management