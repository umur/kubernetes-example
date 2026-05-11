#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch24"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"

# Install CloudNativePG operator
kubectl apply --server-side \
  -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.23/releases/cnpg-1.23.yaml
kubectl wait --for=condition=available --timeout=120s \
  deployment/cnpg-controller-manager -n cnpg-system

kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -
kubectl create secret generic cinetrack-postgres-credentials \
  --from-literal=username=cinetrack_user \
  --from-literal=password=changeme_in_prod \
  --namespace=cinetrack --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f manifests/
echo "✓ Chapter 24: CloudNativePG cluster applied"
echo "Watch: kubectl get cluster cinetrack-postgres -n cinetrack --watch"
