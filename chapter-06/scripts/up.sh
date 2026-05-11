#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch06"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"
kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -

# Apply standard K8s resources
kubectl apply -f manifests/namespace.yaml
kubectl apply -f manifests/db-secret.yaml
kubectl apply -f manifests/catalog-deployment.yaml

# externalsecret.yaml demonstrates the ESO pattern but needs the External Secrets
# Operator installed first: https://external-secrets.io/latest/introduction/getting-started/
echo "NOTE: manifests/externalsecret.yaml requires the External Secrets Operator."
echo "Install ESO: helm install external-secrets external-secrets/external-secrets -n external-secrets-system --create-namespace"
echo "✓ Chapter 06: standard Secret + Deployment applied"
kubectl get all -n cinetrack
