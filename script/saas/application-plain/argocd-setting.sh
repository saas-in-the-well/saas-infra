#!/bin/bash
set -e

#export ARGOCD_SERVER="argocd.jumpsoft.store" # Argo CD 서버 주소를 여기에 설정하세요

# 계정 생성
PATCH_STRING='{"data":{"accounts.tenant-hotel-seoul":"login"}}'
kubectl patch configmap argocd-cm -n argocd --type merge -p "$PATCH_STRING"
echo "############ argocd-setting.sh ############ >>>>> ConfigMap 'argocd-cm' updated successfully."

# Update secret in ArgoCD namespace
kubectl patch secret argocd-secret -n argocd --type='json' -p='[
    {"op": "add", "path": "/data/accounts.tenant-hotel-seoul.password", "value": "JDJiJDEyJGIwRzREWVIwSWppQ3hPZU51YWRmemVhZmo5cWJ3QXdDaC5OZHlOdXpUcWJGOHYxR2VXeGFT"}
]'
echo "############ argocd-setting.sh ############ >>>>> Secret 'argocd-secret' updated successfully."


# Apply patch to ConfigMap
./update-argo-rbac.sh ${TENANT_NAME}


sleep 2
# 프로젝트 및 어플리케이션 생성
kubectl apply -f argoCD-application-config.yaml

