#!/bin/bash

# 클러스터 이름 지정
export CLUSTER_NAME="devops-saas-cloudformation-0531-eks-cluster"

echo "Starting the deployment process..."


chmod +x /Users/jaeho.lee/workspace/saasfication/saas-infra/script/eks/argoCD.sh
./argoCD.sh

chmod +x /Users/jaeho.lee/workspace/saasfication/saas-infra/script/eks/nginx-ingress.sh
./nginx-ingress.sh

chmod +x /Users/jaeho.lee/workspace/saasfication/saas-infra/script/eks/grafana.sh
./grafana.sh

sleep 15

chmod +x /Users/jaeho.lee/workspace/saasfication/saas-infra/script/eks/setting.sh
./setting.sh

echo "All deployments completed successfully."
