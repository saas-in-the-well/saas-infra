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



# 인증서 관련 설치.. -> 이것도 파일로 분리해서 develop 안에 넣어보자
#kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.crds.yaml
#kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.yaml