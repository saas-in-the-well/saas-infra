#!/bin/bash
set -e

###### argoCD 계정 생성

# Define the patch to apply
PATCH_STRING='{"data":{"accounts.hyeongwon":"login","accounts.jaeho":"login","accounts.seongjin":"login","dex.config":"connectors:\n- type: github\n  id: github\n  name: GitHub\n  config:\n    clientID: Ov23ctyIgYBEfYekxFjt\n    clientSecret: 9a0cceecaf3f82dce2bf0617ec190765f6890097\n    orgs:\n    - name: saas-in-the-well\nurl: https://a8a0c088d4a2049cc956e410f79ad495-1239568557.ap-northeast-2.elb.amazonaws.com"}}'


# Apply the patch
kubectl patch configmap argocd-cm -n argocd --type merge -p "$PATCH_STRING"

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

# Restart ArgoCD
kubectl rollout restart deployment argocd-server -n argocd
echo "Restart ArgoCD"




###### Grafana port-forward
#kubectl port-forward service/grafana 3000:3000 --namespace=monitoring