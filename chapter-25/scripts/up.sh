#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch25"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"

kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -

# Install Strimzi operator
kubectl apply -f "https://strimzi.io/install/latest?namespace=cinetrack" -n cinetrack

# Wait for CRDs to be Established
kubectl wait --for=condition=Established crd/kafkas.kafka.strimzi.io --timeout=120s
kubectl wait --for=condition=Established crd/kafkatopics.kafka.strimzi.io --timeout=60s
kubectl wait --for=condition=Established crd/kafkausers.kafka.strimzi.io --timeout=60s

# Retry apply until Kafka REST mapping is fully registered in API server
echo "Waiting for Kafka REST mapping to be ready..."
until kubectl apply -f manifests/ 2>/dev/null; do
  echo "  REST mapping not ready, retrying in 5s..."
  sleep 5
done
echo "✓ Chapter 25: Strimzi Kafka cluster + topics applied"
echo "Watch: kubectl get kafka cinetrack-kafka -n cinetrack --watch"
