#!/bin/bash

# 클러스터 이름 지정
export CLUSTER_NAME="devops-saas-eks-cluster-0522"

echo "Starting the deployment process..."


chmod +x /Users/jaeho.lee/workspace/saasfication/saas-kubernetes/script/argoCD.sh
./argoCD.sh

chmod +x /Users/jaeho.lee/workspace/saasfication/saas-kubernetes/script/nginx-ingress.sh
./nginx-ingress.sh

chmod +x /Users/jaeho.lee/workspace/saasfication/saas-kubernetes/script/grafana.sh
./grafana.sh

chmod +x /Users/jaeho.lee/workspace/saasfication/saas-kubernetes/script/setting.sh
./setting.sh

echo "All deployments completed successfully."
