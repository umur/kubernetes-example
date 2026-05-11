#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch19"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"

kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
# --server-side avoids the "annotation too long" error on ArgoCD CRDs
kubectl apply --server-side -n argocd \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait --for=condition=available --timeout=180s deployment/argocd-server -n argocd

echo "ArgoCD admin password:"
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath='{.data.password}' | base64 -d && echo

kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -
kubectl apply --server-side -f manifests/
echo "✓ Chapter 19: ArgoCD App-of-Apps applied"
echo "Port-forward: kubectl port-forward svc/argocd-server -n argocd 8443:443"
