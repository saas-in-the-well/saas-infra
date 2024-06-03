#!/bin/bash
set -e

# Create ArgoCD namespace -> kube manifest 로 변경 (argoCD-custom.yaml)
#echo "Creating ArgoCD namespace..."
#kubectl create namespace argocd

# Install ArgoCD -> kube manifest 로 변경 (argoCD-install.yaml)
echo "Installing ArgoCD..."
#kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f argoCD-install.yaml --namespace=argocd

# Change ArgoCD server service type to LoadBalancer -> kube manifest 로 변경 (argoCD-custom.yaml)
#echo "Patching ArgoCD service to be accessible externally..."
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# Check ArgoCD server service
echo "Checking ArgoCD server service..."
kubectl get svc argocd-server -n argocd

# echo "ArgoCD setup complete."

# secret 추가
kubectl create secret docker-registry ecr-registry --docker-server=https://794187215716.dkr.ecr.ap-northeast-2.amazonaws.com --docker-username=AWS --docker-password=$(aws ecr get-login-password) --docker-email=hyeongwon.lee@bespinglobal.com --namespace=saas

