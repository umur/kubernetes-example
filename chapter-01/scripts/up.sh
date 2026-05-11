#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch01"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER" --config manifests/kind-config.yaml
fi
kubectl config use-context "kind-$CLUSTER"
kubectl apply -f manifests/namespace.yaml
kubectl apply -f manifests/
echo "✓ Chapter 01: basic cluster + CinéTrack namespace ready"
kubectl get pods -n cinetrack
