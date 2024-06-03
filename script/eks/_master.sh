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

#chmod +x /Users/jaeho.lee/workspace/saasfication/saas-infra/script/eks/nginx-ingress.sh
#./nginx-ingress.sh

#chmod +x /Users/jaeho.lee/workspace/saasfication/saas-infra/script/eks/grafana.sh
#./grafana.sh


sleep 15

# 후처리
chmod +x /Users/jaeho.lee/workspace/saasfication/saas-infra/script/eks/after-setting.sh
./after-setting.sh

echo "All deployments completed successfully."
