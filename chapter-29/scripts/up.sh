#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch29"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"

# Install prometheus-operator CRDs
PROM_CRD_BASE="https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/main/example/prometheus-operator-crd"
kubectl apply --server-side -f "$PROM_CRD_BASE/monitoring.coreos.com_alertmanagerconfigs.yaml"
kubectl apply --server-side -f "$PROM_CRD_BASE/monitoring.coreos.com_prometheusrules.yaml"

kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f manifests/
echo "✓ Chapter 29: AlertmanagerConfig + PrometheusRule + runbooks applied"
