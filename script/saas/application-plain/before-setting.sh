#!/bin/bash
set -e

export CLUSTER_NAME="${PREFIX_NAME}${NOW_DATE}-eks-cluster"
export PREFIX_NAME="devops-saas-cloudformation"

echo "Updating AWS EKS kubeconfig for cluster: $CLUSTER_NAME..."

# Update kubeconfig using the variable
aws eks update-kubeconfig --region ap-northeast-2 --name $CLUSTER_NAME

# 필요한 namespace 생성 -> kube manifest 파일로 변경[임시] (node-label.yaml)
echo "Creating namespaces..."
kubectl create namespace saas
#kubectl create namespace argocd
#kubectl create namespace monitoring
#kubectl create namespace cert-manager

