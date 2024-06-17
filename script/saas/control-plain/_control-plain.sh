#!/bin/bash

export PREFIX_NAME="saas-control-plain-"
export NOW_DATE=0612
export CLUSTER_NAME="${PREFIX_NAME}${NOW_DATE}-eks-cluster"

echo "############ _control-plain.sh ############ >>>>> Updating AWS EKS kubeconfig for cluster: $CLUSTER_NAME..."

# Update kubeconfig using the variable
aws eks update-kubeconfig --region ap-northeast-2 --name $CLUSTER_NAME

echo "############ _control-plain.sh ############ >>>>> [Control Plain] provisioning Starting..."

# 전처리
./before-setting.sh
# argoCD 설치 및 설정
./argoCD.sh

sleep 20

# 후처리
./after-setting.sh

echo "############ _control-plain.sh ############ >>>>> [Control Plain] provisioning End !!!"


