#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch09"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER" 2>/dev/null || true
fi
kubectl config use-context "kind-$CLUSTER"

kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f manifests/
echo "✓ Chapter 09 manifests applied to kind cluster: $CLUSTER"
