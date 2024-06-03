#!/bin/bash
set -e

export CLUSTER_NAME="${PREFIX_NAME}${NOW_DATE}-eks-cluster"

echo "Updating AWS EKS kubeconfig for cluster: $CLUSTER_NAME..."

# Update kubeconfig using the variable
aws eks update-kubeconfig --region ap-northeast-2 --name $CLUSTER_NAME

# 필요한 namespace 생성 -> kube manifest 파일로 변경[임시] (node-label.yaml)
echo "Creating namespaces..."
kubectl create namespace saas
kubectl create namespace argocd
kubectl create namespace monitoring
kubectl create namespace cert-manager

# 노드에 레이블 추가 -> kube manifest 파일로 변경 (node-label.yaml)
echo "Creating label nodes..."
#todo : ip-10-0-4-45.ap-northeast-2.compute.internal -> node 그룹명이아닌 생성된 노드 이름으로 수정해야함.
kubectl label nodes ${PREFIX_NAME}-ManagementNodeGroup node-type=management
kubectl label nodes ${PREFIX_NAME}-ApplicationNodeGroup node-type=application

