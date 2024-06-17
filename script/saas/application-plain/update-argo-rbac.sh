#!/bin/bash

TENANT_NAME=$1

if [ -z "$TENANT_NAME" ]; then
  echo "Usage: $0 <tenant-name>"
  exit 1
fi

EXISTING_POLICY=$(kubectl get configmap argocd-rbac-cm -n argocd -o jsonpath="{.data.policy\.csv}")
echo '=== EXISTING_POLICY [start] ==='
echo ${EXISTING_POLICY}
echo '=== EXISTING_POLICY [end] ==='

NEW_TENANT_POLICY="p, role:$TENANT_NAME, applications, *, $TENANT_NAME/*, allow\np, role:$TENANT_NAME, repositories, *, $TENANT_NAME/*, allow\ng, $TENANT_NAME, role:$TENANT_NAME"
echo '@@@ NEW_TENANT_POLICY [start] @@@'
echo ${NEW_TENANT_POLICY}
echo '@@@ NEW_TENANT_POLICY [end] @@@'

UPDATED_POLICY="${EXISTING_POLICY}\n${NEW_TENANT_POLICY}"
echo '### UPDATED_POLICY [start] ###'
echo ${UPDATED_POLICY}
echo '### UPDATED_POLICY [end] ###'

kubectl patch configmap argocd-rbac-cm -n argocd --type merge -p "{\"data\":{\"policy.csv\":\"${UPDATED_POLICY}\"}}"
