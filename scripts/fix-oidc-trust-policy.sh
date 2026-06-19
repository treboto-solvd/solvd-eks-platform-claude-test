#!/bin/bash
# Fix OIDC trust policy for GitHub Actions IAM roles
# The trust policy needs to be more permissive to match the actual OIDC token sub claim
set -euo pipefail

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
OIDC_ARN="arn:aws:iam::${ACCOUNT_ID}:oidc-provider/token.actions.githubusercontent.com"
REPO="treboto-solvd/solvd-eks-platform-claude-test"

echo "Account: $ACCOUNT_ID"
echo "OIDC ARN: $OIDC_ARN"
echo "Repo: $REPO"

for env_name in test staging prod; do
  ROLE_NAME="eks-platform-github-actions-${env_name}"
  
  echo ""
  echo "=== Updating trust policy for $ROLE_NAME ==="
  
  # Create a more permissive trust policy that matches all possible sub claim formats
  cat > /tmp/trust-policy-${env_name}.json << EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${OIDC_ARN}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
        },
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:${REPO}:*"
        }
      }
    }
  ]
}
EOF

  aws iam update-assume-role-policy \
    --role-name "$ROLE_NAME" \
    --policy-document "file:///tmp/trust-policy-${env_name}.json"
  
  echo "Updated trust policy for $ROLE_NAME"
  
  # Show the current trust policy
  aws iam get-role --role-name "$ROLE_NAME" --query 'Role.AssumeRolePolicyDocument' --output json | jq .
done

echo ""
echo "=== All trust policies updated ==="
echo "The trust policies now accept any sub claim matching: repo:${REPO}:*"
echo "This covers: environment:test, ref:refs/heads/main, pull_request, etc."
