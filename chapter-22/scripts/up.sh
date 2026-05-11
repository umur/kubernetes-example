#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch22"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"

# Install Kyverno (--server-side avoids annotation size limit on large CRDs)
kubectl apply --server-side -f \
  https://github.com/kyverno/kyverno/releases/latest/download/install.yaml

# Kyverno 1.12+ splits into multiple controllers
kubectl wait --for=condition=available --timeout=180s \
  deployment/kyverno-admission-controller -n kyverno

kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f manifests/
echo "✓ Chapter 22: Kyverno supply chain policies applied"
echo "Test: kubectl get clusterpolicy"
