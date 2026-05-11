#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch28"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"
kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -

# Wait for the default service account to be created in the new namespace
# (takes a moment after namespace creation in newer Kubernetes versions)
until kubectl get serviceaccount default -n cinetrack &>/dev/null; do sleep 1; done

kubectl apply -f manifests/
echo "✓ Chapter 28: debug pod applied"
echo "Debug commands: ./scripts/debug.sh <pod-name>"
