#!/bin/bash
set -e

# Restart ArgoCD
kubectl rollout restart deployment argocd-server -n argocd
echo "Restart ArgoCD"

# Check ArgoCD server service
echo "Checking ArgoCD loadbalencer service..."
kubectl get svc argocd-server -n argocd
