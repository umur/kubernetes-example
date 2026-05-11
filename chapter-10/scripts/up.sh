#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch10"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"

# Install nginx ingress controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl wait --namespace ingress-nginx --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller --timeout=90s

# Install Gateway API CRDs (needed for HTTPRoute/Gateway resources)
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/latest/download/standard-install.yaml

kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f manifests/
echo "✓ Chapter 10: Ingress + Gateway API applied"
echo "Add to /etc/hosts: 127.0.0.1 cinetrack.local"
