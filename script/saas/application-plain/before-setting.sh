#!/bin/bash
set -e

# Update kubeconfig using the variable
aws eks update-kubeconfig --region ap-northeast-2 --name $CLUSTER_NAME

# 필요한 namespace 생성 -> kube manifest 파일로 변경[임시] (node-label.yaml)
echo "Creating namespaces..."
kubectl create namespace ${TENANT_NAME}

# secret 추가
kubectl create secret docker-registry ecr-registry --docker-server=https://794187215716.dkr.ecr.ap-northeast-2.amazonaws.com --docker-username=AWS --docker-password=$(aws ecr get-login-password) --docker-email=hyeongwon.lee@bespinglobal.com --namespace=${TENANT_NAME}