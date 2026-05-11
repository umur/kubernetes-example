#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch22"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"
# Install Kyverno
kubectl create -f https://github.com/kyverno/kyverno/releases/latest/download/install.yaml
kubectl wait --for=condition=available --timeout=120s deployment/kyverno -n kyverno
kubectl apply -f manifests/
echo "✓ Chapter 22: Supply chain policies applied"
echo "Test: kubectl get clusterpolicy"
