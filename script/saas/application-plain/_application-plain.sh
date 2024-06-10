#!/bin/bash

# 클러스터 이름 지정
export PREFIX_NAME="devops-saas-cloudformation-"
export NOW_DATE=$(date +%m%d)


echo " ##### [Application Plain] provisioning Starting... ##### "

# 전처리
#chmod +x /Users/jaeho.lee/workspace/saasfication/saas-infra/script/saas/application-plain/before-setting.sh
./before-setting.sh


#sleep 10

# 후처리
#chmod +x /Users/jaeho.lee/workspace/saasfication/saas-infra/script/saas/application-plain/after-setting.sh
#./after-setting.sh

echo " ##### [Application Plain] provisioning End !!! ##### "


# TODO ArgoCD에 git repository 등록 및 어플리케이션 등록.. project 는 tenant 명으로 생성