#!/usr/bin/env bash
# Common debugging commands for CinéTrack on Kubernetes
set -euo pipefail

POD_NAME="${1:-}"
NAMESPACE="cinetrack"

if [[ -z "$POD_NAME" ]]; then
  echo "Usage: $0 <pod-name>"
  echo ""
  echo "Available pods:"
  kubectl get pods -n "$NAMESPACE" -o wide
  exit 1
fi

echo "=== Pod describe ==="
kubectl describe pod "$POD_NAME" -n "$NAMESPACE"

echo ""
echo "=== Recent logs ==="
kubectl logs "$POD_NAME" -n "$NAMESPACE" --tail=100

echo ""
echo "=== Attach ephemeral debug container ==="
echo "Running: kubectl debug -it $POD_NAME -n $NAMESPACE --image=nicolaka/netshoot --target=catalog-service"
kubectl debug -it "$POD_NAME" -n "$NAMESPACE" --image=nicolaka/netshoot --target=catalog-service
