#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch11"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"

# Install Gateway API CRDs (HTTPRoute is a Gateway API resource)
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.1/standard-install.yaml
kubectl wait --for=condition=Established crd/httproutes.gateway.networking.k8s.io --timeout=60s

kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f manifests/
echo "✓ Chapter 11: Ingress + HTTPRoute resilience manifests applied"
