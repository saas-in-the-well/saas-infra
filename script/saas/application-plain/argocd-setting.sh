#!/bin/bash
set -e

export PREFIX_NAME="devops-saas-control-plain-"
export NOW_DATE=$(date +%m%d)
export TENANT_NAME=tenant-hotel-seoul

export CLUSTER_NAME="${PREFIX_NAME}${NOW_DATE}-eks-cluster"
export ARGOCD_SERVER="a58012553c125423eb8bf399839105fc-1818683353.ap-northeast-2.elb.amazonaws.com" # Argo CD 서버 주소를 여기에 설정하세요

# 계정 생성
# Update secret in ArgoCD namespace
kubectl patch secret argocd-secret -n argocd --type='json' -p='[
    {"op": "add", "path": "/data/accounts.jaeho.password", "value": "JDJiJDEyJGIwRzREWVIwSWppQ3hPZU51YWRmemVhZmo5cWJ3QXdDaC5OZHlOdXpUcWJGOHYxR2VXeGFT"},
]'

echo "Secret 'argocd-secret' updated successfully."

# 로그인..
argocd login ${ARGOCD_SERVER} --insecure --username jaeho --password admin1234

# argoCD 프로젝트 설정
argocd proj create example-project \
  --description "This is an ${TENANT_NAME} project" \
  --dest https://kubernetes.default.svc:443,${TENANT_NAME} \
  --src https://github.com/saas-in-the-well/saas-kubernetes.git


