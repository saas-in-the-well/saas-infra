#!/bin/bash
set -e


echo "Updating AWS EKS kubeconfig for cluster: $CLUSTER_NAME..."

# Update kubeconfig using the variable
aws eks update-kubeconfig --region ap-northeast-2 --name $CLUSTER_NAME

# Create ArgoCD namespace
echo "Creating ArgoCD namespace..."
kubectl create namespace saas
kubectl create namespace argocd

# Install ArgoCD
echo "Installing ArgoCD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Change ArgoCD server service type to LoadBalancer
echo "Patching ArgoCD service to be accessible externally..."
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# Retrieve ArgoCD initial admin password
echo "Retrieving ArgoCD initial admin password..."
#생략 가능..
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
echo "ArgoCD initial admin password retrieved."

# Check ArgoCD server service
echo "Checking ArgoCD server service..."
kubectl get svc argocd-server -n argocd

echo "ArgoCD setup complete."