#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch13"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"
# Install Istio (requires istioctl in PATH)
if command -v istioctl &>/dev/null; then
  istioctl install --set profile=minimal -y
else
  echo "istioctl not found — install from https://istio.io/latest/docs/setup/install/istioctl/"
  exit 1
fi
kubectl apply -f manifests/
echo "✓ Chapter 13: Istio mTLS + VirtualService + DestinationRule applied"
