#!/bin/bash
set -e

###### argoCD 계정 생성

# Define the patch to apply
PATCH_STRING='{"data":{"accounts.hyeongwon":"login","accounts.jaeho":"login","accounts.seongjin":"login"}}'

# Apply the patch
kubectl patch configmap argocd-cm -n argocd --type merge -p $PATCH_STRING

echo "ConfigMap 'argocd-cm' updated successfully."

# Update secret in ArgoCD namespace
kubectl patch secret argocd-secret -n argocd --type='json' -p='[
    {"op": "add", "path": "/data/accounts.hyeongwon.password", "value": "JDJiJDEyJGIwRzREWVIwSWppQ3hPZU51YWRmemVhZmo5cWJ3QXdDaC5OZHlOdXpUcWJGOHYxR2VXeGFT"},
    {"op": "add", "path": "/data/accounts.jaeho.password", "value": "JDJiJDEyJGIwRzREWVIwSWppQ3hPZU51YWRmemVhZmo5cWJ3QXdDaC5OZHlOdXpUcWJGOHYxR2VXeGFT"},
    {"op": "add", "path": "/data/accounts.seongjin.password", "value": "JDJiJDEyJGIwRzREWVIwSWppQ3hPZU51YWRmemVhZmo5cWJ3QXdDaC5OZHlOdXpUcWJGOHYxR2VXeGFT"}
]'

echo "Secret 'argocd-secret' updated successfully."


# Apply patch to ConfigMap
kubectl patch configmap argocd-rbac-cm -n argocd --type merge -p '{"data":{"policy.default":"role:admin"}}'

echo "ConfigMap 'argocd-rbac-cm' updated successfully."



###### Grafana port-forward
kubectl port-forward service/grafana 3000:3000 --namespace=monitoring