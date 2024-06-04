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
kubectl create namespace argocd
kubectl create namespace monitoring
kubectl create namespace cert-manager

echo "Creating label nodes..."
# Management 노드 그룹의 노드 라벨 추가
management_node_group_label="eks.amazonaws.com/nodegroup=${PREFIX_NAME}ManagementNodeGroup"
kubectl get nodes -l "$management_node_group_label" -o custom-columns=NAME:.metadata.name | tail -n +2 | while read -r node; do
    echo "Labeling node: $node with node-type=management"
    kubectl label nodes "$node" node-type=management --overwrite
done

# Application 노드 그룹의 노드 라벨 추가
application_node_group_label="eks.amazonaws.com/nodegroup=${PREFIX_NAME}ApplicationNodeGroup"
kubectl get nodes -l "$application_node_group_label" -o custom-columns=NAME:.metadata.name | tail -n +2 | while read -r node; do
    echo "Labeling node: $node with node-type=application"
    kubectl label nodes "$node" node-type=application --overwrite
done