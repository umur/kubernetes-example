#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch14"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"

# Install metrics-server for CPU/memory HPA
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl patch deployment metrics-server -n kube-system --type='json' \
  -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'

kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -

# Apply the standard HPA (autoscaling/v2: built-in K8s)
kubectl apply -f manifests/namespace.yaml
kubectl apply -f manifests/catalog-hpa.yaml

# keda-scaledobject.yaml requires KEDA operator:
# helm install keda kedacore/keda --namespace keda --create-namespace
echo "NOTE: manifests/keda-scaledobject.yaml requires KEDA (https://keda.sh)"
echo "✓ Chapter 14: HPA applied; KEDA ScaledObject needs KEDA operator"
kubectl get hpa -n cinetrack
