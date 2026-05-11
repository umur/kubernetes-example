#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch32"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"
# metrics-server for HPA
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl patch deployment metrics-server -n kube-system --type='json' \
  -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'
kubectl apply -f manifests/
echo "✓ Chapter 32 capstone manifests applied"
echo ""
echo "Run load test:"
echo "  kubectl apply -f manifests/k6-capstone.yaml"
echo "  kubectl create job capstone-test --from=cronjob/k6 -n cinetrack  # or run k6 locally"
echo ""
echo "Watch scaling:"
echo "  kubectl get hpa -n cinetrack --watch"
