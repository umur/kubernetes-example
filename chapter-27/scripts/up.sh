#!/usr/bin/env bash
set -euo pipefail
CLUSTER="cinetrack-ch27"
if ! kind get clusters 2>/dev/null | grep -q "^$CLUSTER$"; then
  kind create cluster --name "$CLUSTER"
fi
kubectl config use-context "kind-$CLUSTER"

# Install prometheus-operator CRDs (needed for ServiceMonitor + PrometheusRule)
PROM_CRD_BASE="https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/main/example/prometheus-operator-crd"
kubectl apply --server-side -f "$PROM_CRD_BASE/monitoring.coreos.com_servicemonitors.yaml"
kubectl apply --server-side -f "$PROM_CRD_BASE/monitoring.coreos.com_prometheusrules.yaml"
kubectl apply --server-side -f "$PROM_CRD_BASE/monitoring.coreos.com_podmonitors.yaml"

kubectl create namespace cinetrack --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f manifests/
echo "✓ Chapter 27: OTel Collector + ServiceMonitor + PrometheusRule applied"
