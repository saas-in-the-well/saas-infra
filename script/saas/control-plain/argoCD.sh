#!/bin/bash
set -e

# Create ArgoCD namespace -> kube manifest 로 변경 (argoCD-custom.yaml)
#echo "Creating ArgoCD namespace..."
#kubectl create namespace argocd

# Install ArgoCD -> kube manifest 로 변경 (argoCD-install.yaml)
echo "############ argoCD.sh ############ >>>>> Installing ArgoCD..."
#kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f argoCD-install.yaml --namespace=argocd

echo "############ argoCD.sh ############ >>>>> Inatalled ArgoCD..."

sleep 2

# Change ArgoCD server service type to LoadBalancer -> kube manifest 로 변경 (argoCD-custom.yaml)
#echo "Patching ArgoCD service to be accessible externally..."
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

sleep 2

###### argoCD 계정 생성

# Define the patch to apply
PATCH_STRING='{"data":{"accounts.hyeongwon":"login","accounts.jaeho":"login","accounts.seongjin":"login","dex.config":"connectors:\n- type: github\n  id: github\n  name: GitHub\n  config:\n    clientID: Ov23ctyIgYBEfYekxFjt\n    clientSecret: 9a0cceecaf3f82dce2bf0617ec190765f6890097\n    orgs:\n    - name: saas-in-the-well\nredirectURI: https://argocd.jumpsoft.store/dex/callback"}}'
kubectl patch configmap argocd-cm -n argocd --type merge -p "$PATCH_STRING"
echo "############ argoCD.sh ############ >>>>> ConfigMap 'argocd-cm' updated successfully."

# Update secret in ArgoCD namespace
kubectl patch secret argocd-secret -n argocd --type='json' -p='[
    {"op": "add", "path": "/data/accounts.hyeongwon.password", "value": "JDJiJDEyJGIwRzREWVIwSWppQ3hPZU51YWRmemVhZmo5cWJ3QXdDaC5OZHlOdXpUcWJGOHYxR2VXeGFT"},
    {"op": "add", "path": "/data/accounts.jaeho.password", "value": "JDJiJDEyJGIwRzREWVIwSWppQ3hPZU51YWRmemVhZmo5cWJ3QXdDaC5OZHlOdXpUcWJGOHYxR2VXeGFT"},
    {"op": "add", "path": "/data/accounts.seongjin.password", "value": "JDJiJDEyJGIwRzREWVIwSWppQ3hPZU51YWRmemVhZmo5cWJ3QXdDaC5OZHlOdXpUcWJGOHYxR2VXeGFT"}
]'
echo "############ argoCD.sh ############ >>>>> Secret 'argocd-secret' updated successfully."


# Apply patch to ConfigMap
#kubectl patch configmap argocd-rbac-cm -n argocd --type merge -p '{"data":{"policy.default":"role:readonly"}}'
kubectl patch configmap argocd-rbac-cm -n argocd --type merge -p '{
  "data": {
    "policy.csv": "p, role:admin, applications, *, */*, allow\\np, role:admin, projects, *, */*, allow\\np, role:admin, clusters, *, *, allow\\np, role:admin, repositories, *, *, allow\\np, role:admin, applications, get, manage-application, allow\\np, role:admin, applications, create, manage-application, allow\\np, role:admin, applications, update, manage-application, allow\\np, role:admin, applications, delete, manage-application, allow\\ng, admin, role:admin\\ng, hyeongwon, role:admin\\ng, jaeho, role:admin\\ng, seongjin, role:admin"
  }
}'

echo "############ argoCD.sh ############ >>>>> ConfigMap 'argocd-rbac-cm' updated successfully."


sleep 2 # 프로젝트 바로 생성 시 오류 발생..
# 프로젝트 및 어플리케이션 생성
kubectl apply -f argoCD-admin-config.yaml


echo "############ argoCD.sh ############ >>>>> project & application create"