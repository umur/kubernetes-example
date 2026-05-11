#!/usr/bin/env bash
set -euo pipefail
echo "NOTE: Multi-cluster requires real clusters. Demonstrating ApplicationSet locally:"
CLUSTER="cinetrack-ch31"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait --for=condition=available --timeout=120s deployment/argocd-server -n argocd
kubectl apply -f manifests/
echo "✓ Chapter 31: ApplicationSet applied (update cluster-secret URLs for real clusters)"
