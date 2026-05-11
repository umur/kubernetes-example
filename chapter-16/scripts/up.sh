#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch16"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"
# Install VPA (required for VPA resources)
if ! kubectl get crd verticalpodautoscalers.autoscaling.k8s.io &>/dev/null; then
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/master/vertical-pod-autoscaler/deploy/vpa-v1-crd-gen.yaml
fi
kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f manifests/
echo "✓ Chapter 16: VPA + PDB + PriorityClass applied"
