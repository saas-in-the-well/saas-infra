#!/bin/bash

# 클러스터 이름 지정
export PREFIX_NAME="devops-saas-cloudformation-"
export NOW_DATE=$(date +%m%d)


echo "Starting the deployment process..."

# 전처리
chmod +x /Users/jaeho.lee/workspace/saasfication/saas-infra/script/eks/before-setting.sh
./before-setting.sh

chmod +x /Users/jaeho.lee/workspace/saasfication/saas-infra/script/eks/argoCD.sh
./argoCD.sh


sleep 10

# 후처리
chmod +x /Users/jaeho.lee/workspace/saasfication/saas-infra/script/eks/after-setting.sh
./after-setting.sh

echo "All deployments completed successfully."


sleep 10

###### Grafana port-forward
#kubectl port-forward service/grafana 3000:3000 --namespace=monitoring