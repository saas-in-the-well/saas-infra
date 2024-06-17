#!/bin/bash
set -e

# Restart ArgoCD
kubectl rollout restart deployment argocd-server -n argocd
echo "############ after-setting.sh ############ >>>>> Restart ArgoCD"

# Check ArgoCD server service
echo "############ after-setting.sh ############ >>>>> Checking ArgoCD loadbalencer service..."
kubectl get svc argocd-server -n argocd
