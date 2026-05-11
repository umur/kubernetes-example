#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch24"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"

# Fetch latest CloudNativePG release tag and build install URL dynamically
CNPG_TAG=$(curl -s https://api.github.com/repos/cloudnative-pg/cloudnative-pg/releases/latest \
  | python3 -c "import sys,json; t=json.load(sys.stdin)['tag_name']; print(t)")
CNPG_VERSION="${CNPG_TAG#v}"
CNPG_MINOR=$(echo "$CNPG_VERSION" | cut -d. -f1-2)
CNPG_URL="https://github.com/cloudnative-pg/cloudnative-pg/releases/download/$CNPG_TAG/cnpg-$CNPG_VERSION.yaml"
echo "Installing CloudNativePG $CNPG_TAG from $CNPG_URL"

kubectl apply --server-side -f "$CNPG_URL"
kubectl wait --for=condition=available --timeout=120s \
  deployment/cnpg-controller-manager -n cnpg-system

kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -
kubectl create secret generic cinetrack-postgres-credentials \
  --from-literal=username=cinetrack_user \
  --from-literal=password=changeme_in_prod \
  --namespace=cinetrack --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f manifests/
echo "✓ Chapter 24: CloudNativePG $CNPG_TAG cluster applied"
echo "Watch: kubectl get cluster cinetrack-postgres -n cinetrack --watch"
