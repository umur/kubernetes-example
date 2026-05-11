#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch30"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"

kubectl apply -f manifests/
echo "✓ Chapter 30 applied"
