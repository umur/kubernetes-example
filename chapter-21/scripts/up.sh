#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch21"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"
kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f manifests/namespace.yaml

echo "=== Applying Kustomize dev overlay ==="
kubectl apply -k manifests/kustomize/overlays/dev/
echo "✓ Chapter 21: Kustomize overlays applied"
echo "To apply prod: kubectl apply -k manifests/kustomize/overlays/prod/"
