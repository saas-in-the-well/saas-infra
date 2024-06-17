#!/bin/bash

# 클러스터 이름 지정
export PREFIX_NAME="saas-control-plain-"
#export NOW_DATE=$(date +%m%d)
export NOW_DATE=0612
export CLUSTER_NAME="${PREFIX_NAME}${NOW_DATE}-eks-cluster"

echo "Updating AWS EKS kubeconfig for cluster: $CLUSTER_NAME..."

export TENANT_NAME=tenant-hotel-seoul

echo " ##### [Application Plain] tenant name is [${TENANT_NAME}] ##### "
echo " ##### provisioning Starting... ##### "

# 전처리
#chmod +x /Users/jaeho.lee/workspace/saasfication/saas-infra/script/saas/application-plain/before-setting.sh
./before-setting.sh


#sleep 10

# 후처리
#chmod +x /Users/jaeho.lee/workspace/saasfication/saas-infra/script/saas/application-plain/after-setting.sh
#./after-setting.sh

echo " ##### [Application Plain] provisioning End !!! ##### "


# TODO ArgoCD에 git repository 등록 및 어플리케이션 등록.. project 는 tenant 명으로 생성
./argocd-setting.sh