#!/bin/bash

# argoCD에서 동적으로 궠한을 추가하기 위한 스크립트 파일
# 기존 정책을 불러오고, 신규 생성된 테넌트 정책을 뒤에 붙여서 권한을 추가한다.

# 입력 인자 체크
if [ -z "$1" ]; then
  echo "Usage: $0 <tenant-name>"
  exit 1
fi

TENANT_NAME=$1

# 기존 정책 가져오기
EXISTING_POLICY=$(kubectl get configmap argocd-rbac-cm -n argocd -o jsonpath="{.data.policy\.csv}")

# 기존 정책 로그 출력
echo "=== EXISTING_POLICY ==="
echo "$EXISTING_POLICY"

# 새로운 테넌트 정책 정의
NEW_TENANT_POLICY=$(cat <<EOF
p, role:${TENANT_NAME}, applications, *, ${TENANT_NAME}/*, allow
p, role:${TENANT_NAME}, projects, *, ${TENANT_NAME}-project/*, allow
g, ${TENANT_NAME}, role:${TENANT_NAME}
EOF
)

# 새로운 정책 로그 출력
echo "@@@@ NEW_TENANT_POLICY @@@@"
echo "$NEW_TENANT_POLICY"

# 기존 정책에 새로운 정책 추가
UPDATED_POLICY="${EXISTING_POLICY}
${NEW_TENANT_POLICY}"

# 업데이트된 정책 로그 출력
echo "##### UPDATED_POLICY #####"
echo "$UPDATED_POLICY"

# 줄바꿈과 따옴표를 이스케이프 처리
ESCAPED_POLICY=$(echo "$UPDATED_POLICY" | awk '{printf "%s\\n", $0}' | sed 's/"/\\"/g')

# 이스케이프 처리된 정책 로그 출력
echo "$$$$$$ ESCAPED_POLICY $$$$$$"
echo "$ESCAPED_POLICY"

# ConfigMap 업데이트
kubectl patch configmap argocd-rbac-cm -n argocd --type merge -p "{\"data\":{\"policy.csv\":\"${ESCAPED_POLICY}\"}}"

echo "Policy updated for tenant: ${TENANT_NAME}"