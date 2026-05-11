#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch07"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER" 2>/dev/null || true
fi
kubectl config use-context "kind-$CLUSTER"

kubectl apply -f manifests/
echo "✓ Chapter 07 manifests applied to kind cluster: $CLUSTER"
