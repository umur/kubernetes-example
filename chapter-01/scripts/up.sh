#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch01"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER" --config manifests/kind-config.yaml
fi
kubectl config use-context "kind-$CLUSTER"
kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -
# Apply all manifests except kind-config.yaml (that is a kind config, not a K8s resource)
for f in manifests/*.yaml; do
  [[ "$f" == *"kind-config.yaml" ]] && continue
  kubectl apply -f "$f"
done
echo "✓ Chapter 01: basic cluster + CinéTrack namespace ready"
kubectl get pods -n cinetrack
