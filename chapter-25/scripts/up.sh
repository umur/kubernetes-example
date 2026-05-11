#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch25"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"
# Install Strimzi operator
kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f "https://strimzi.io/install/latest?namespace=cinetrack" -n cinetrack
kubectl wait --for=condition=ready pod -l name=strimzi-cluster-operator -n cinetrack --timeout=120s
kubectl apply -f manifests/
echo "✓ Chapter 25: Strimzi Kafka cluster + topics applied"
echo "Watch: kubectl get kafka cinetrack-kafka -n cinetrack --watch"
