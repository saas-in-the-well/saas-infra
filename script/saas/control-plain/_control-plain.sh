#!/bin/bash

# 클러스터 이름 지정
export PREFIX_NAME="saas-control-plain-"
export NOW_DATE=$(date +%m%d)
export CLUSTER_NAME="${PREFIX_NAME}${NOW_DATE}-eks-cluster"

echo "Updating AWS EKS kubeconfig for cluster: $CLUSTER_NAME..."

# Update kubeconfig using the variable
aws eks update-kubeconfig --region ap-northeast-2 --name $CLUSTER_NAME

echo " ----- [Control Plain] provisioning Starting... ----- "

# 전처리
./before-setting.sh
# argoCD 설치 및 설정
./argoCD.sh

sleep 20

# 후처리
./after-setting.sh

echo " ----- [Control Plain] provisioning End !!! ----- "


# TODO ArgoCD에 git repository 등록 및 어플리케이션 등록.. project 는 management (?) 명으로 생성

