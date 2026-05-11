#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch20"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"
# Install Argo Rollouts
kubectl create namespace argo-rollouts --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml
kubectl wait --for=condition=available --timeout=120s deployment/argo-rollouts -n argo-rollouts
kubectl apply -f manifests/
echo "✓ Chapter 20: Argo Rollout with canary strategy applied"
echo "Monitor: kubectl argo rollouts get rollout catalog-service -n cinetrack --watch"
